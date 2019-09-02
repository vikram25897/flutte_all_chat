import 'dart:convert';
import 'dart:io';

import 'package:chat/models/members.dart';
import 'package:chat/models/message.dart';
import 'package:chat/res/values.dart';
import 'package:chat/sockets/file_transfer.dart';
import 'package:chat/utils/file_pick.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'connection_manager.g.dart';

class ConnectionManager = _ConnectionManager with _$ConnectionManager;

abstract class _ConnectionManager with Store {
  Socket socket;
  Utf8Decoder _decoder = Utf8Decoder();
  @observable
  ObservableList<Member> members = ObservableList<Member>();
  String localIp;
  @observable
  int activeMember = -1;
  ServerSocket receivingSocket;
  @observable
  ObservableList<FileTransfer> fileTransfers = ObservableList<FileTransfer>();
  @observable
  SocketState socketState = SocketState.INACTIVE;
  String name;

  @computed
  List<Message> get currentMessages => List<Message>.of(messages.where((m) =>
      m.receiver == members[activeMember].name ||
      m.sender == members[activeMember].name));

  init() async {
    try {
      socketState = SocketState.CONNECTING;
      ConnectionTask task = await Socket.startConnect(IP_ADDRESS, PORT);
      socket = await task.socket;
      socketState = SocketState.IDLE;
      socket.listen(_handleData);
      String x;
      if ((x = (await SharedPreferences.getInstance()).getString("username")) !=
          null) {
        sendHello(x);
      }
    } catch (e) {
      socketState = SocketState.FAILED;
      print(e);
    }
  }

  @action
  setActiveChat(int i) {
    activeMember = i;
  }

  @observable
  ObservableList<Message> messages = ObservableList<Message>();

  close() async {
    await socket.close();
  }

  @action
  _handleData(List<int> data) async {
    var encodedData = _decoder.convert(data);
    print(encodedData);
    var json = jsonDecode(encodedData);
    print(json);
    switch (json['type'].trim()) {
      case "message_sent":
        {
          messages.forEach((m) {
            if (m.messageId == json['message_id'].trim()) {
              m.sent = true;
            }
            notifyChange();
          });
          break;
        }
      case "message_received":
        {
          messages.add(Message(
              data: json['message'].trim(),
              sender: json['sender'].trim(),
              messageType: MessageType.RECEIVED));
          break;
        }
      case "entered_chat":
        {
          members.addAll(List<Member>.generate(json["members"].length,
              (i) => Member.fromJson(json["members"][i])));
          localIp = json["ip"].trim();
          await (await SharedPreferences.getInstance())
              .setString("username", name);
          socketState = SocketState.CONNECTED;
          keepReceiving();
          break;
        }
      case "welcome":
        {
          members.add(Member.fromJson(json["who"]));
          break;
        }
      case "gone":
        {
          members.removeWhere((m) => m.name == json["who"].trim());
        }
    }
  }

  @action
  void notifyChange() {
    socketState = socketState;
  }

  @action
  sendMessage(String data) async {
    Message message = Message(
        data: data,
        receiver: members[activeMember].name,
        messageId: Uuid().v4(),
        messageType: MessageType.SENT,
        sent: false);
    messages.add(message);
    socket.write(jsonEncode(message.toJson()));
    socket.flush();
  }

  @action
  sendHello(String userName) {
    name = userName;
    socketState = SocketState.CONNECTING;
    socket.write(json.encode({"name": name}));
    List<int> bytes;
    socket.write(bytes);
    socket.flush();
  }

  @action
  sendFile() async {
    String path = await filePicker.pickSingle(fileType: FileType.ANY);
    if(path==null)
      return;
    FileTransfer fileTransfer;
    fileTransfer = FileTransfer(
      onDone: (){
        fileTransfers.remove(fileTransfer);
        messages.add(Message(
            receiver: fileTransfer.other,
            messageType: MessageType.FILE_SENT,
            data: basename(fileTransfer.filePath),
            messageId: getFileSize(fileTransfer.totalBytes)
        ));
      },
      onProgress: (){
        members = members;
      },
      onError: (e){
        print(e);
        fileTransfers.remove(fileTransfer);
      }
    );
    print(members[activeMember].toJson());
    fileTransfer.otherPartyIp = members[activeMember].ip;
    fileTransfer.port = RECEIVING_PORT;
    fileTransfer.filePath = path;
    fileTransfer.type = TransferType.Sending;
    fileTransfer.other = members[activeMember].name;
    print("other party ip=>${fileTransfer.otherPartyIp}");
      fileTransfer.socket =
          await Socket.connect(fileTransfer.otherPartyIp, RECEIVING_PORT);
      fileTransfers.add(fileTransfer);
      fileTransfer.send();
  }

  @action
  keepReceiving() async {
    print("received local ip $localIp");
      receivingSocket = await ServerSocket.bind(localIp, RECEIVING_PORT);
      receivingSocket.listen((s) async {
        FileTransfer fileTransfer;
        fileTransfer = FileTransfer(
          onDone: (){
            fileTransfers.remove(fileTransfer);
            messages.add(Message(
              sender: fileTransfer.other,
              messageType: MessageType.FILE_RECEIVED,
              data: basename(fileTransfer.filePath),
              messageId: getFileSize(fileTransfer.totalBytes)
            ));
          },
          onError: (e){
            fileTransfers.remove(fileTransfer);
          }
        );
        fileTransfer.receive(s);
      });
  }
}
getFileSize(int x){
  if(x>1024*1024*1024)
    return (x/(1024.0*1024.0*1024.0)).toStringAsFixed(3) + " GB";
  if(x>1024*1024)
    return (x/(1024.0*1024.0)).toStringAsFixed(3) + " MB";
  if(x>1024)
    return (x/(1024.0)).toStringAsFixed(3) + " KB";
  return "$x Bytes";
}
enum SocketState { INACTIVE, IDLE, CONNECTING, CONNECTED, FAILED }
