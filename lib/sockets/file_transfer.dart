import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat/res/values.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileTransfer {
  TransferType type;
  String otherPartyIp;
  int port;
  Socket socket;
  String filePath;
  int progress = 0;
  int totalBytes;
  int transferredBytes = 0;
  String error;
  String other;
  final Function onDone;
  final Function onProgress;
  final Function onError;
  FileTransfer({this.onDone, this.onProgress,this.onError});

  send() async {
    File file = File(filePath);
    if (await file.exists()) {
      totalBytes = await file.length();
      if (socket == null) socket = await Socket.connect(otherPartyIp, port);
      socket.write(jsonEncode({
        "length": totalBytes,
        "name": basename(filePath),
        "sender": (await SharedPreferences.getInstance()).getString("username")
      }).toString());
      await socket.flush();
      await Future.delayed(Duration(seconds: 2));
      socket
        ..addStream(file.openRead()).then((val) {
          onDone();
          print("file sent yar");
          socket.flush();
          socket.close();
        }, onError: (e) {
          print("file send error $e");
          socket.close();
          onError(e);// -1 denotes, file transfer has failed
        });
    } else
      error = "File Does Not Exist";
  }

  void receive(Socket socket) async {
    var _decoder = Utf8Decoder();
    File file;
    IOSink ios;
    bool started = false;
    final stream = socket.asBroadcastStream();
    stream.listen((data) async {
      if(!started) {
        var map = jsonDecode(_decoder.convert(data));
        totalBytes = map['length'];
        print("length to receive $totalBytes");
        filePath = basePath+ map['name'];
        filePath = filePath.substring(1);
        other = map['sender'];
        file = File(filePath);
        print(filePath);
        if(!file.existsSync())
        file.createSync(recursive: true);
        started = true;
        file.openWrite().addStream(stream)
          ..then((x) {
            print(x.runtimeType);
            socket.close();
            onDone();
          })
          ..catchError((e) {
            print("receive error =>$e");
            socket.close();
            file.deleteSync();
            onError(e);
          });
      } else {
        transferredBytes = transferredBytes + data.length;
      }
    }, onError: (e) async {
      await file.delete();
      this.error = e.toString();
      ios.close();
    });
  }
}

enum TransferType { Sending, Receiving }
