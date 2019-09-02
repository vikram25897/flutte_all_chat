import 'dart:io';
import 'package:chat/routes/routes.dart';
import 'package:chat/screens/chat/chat_screen.dart';
import 'package:chat/sockets/connection_manager.dart';
import 'package:chat/widgets/simple_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uuid/uuid.dart';

class SplashScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(Platform.operatingSystem);
    return Scaffold(
      appBar: AppBar(
        title: Text("GeekyAnts Chat"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Observer(builder: (context) {
              if (App.of(context).connectionManager.socketState ==
                  SocketState.INACTIVE) {
                App.of(context).connectionManager.init();
              }
              if (App.of(context).connectionManager.socketState ==
                  SocketState.FAILED) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (c) => Scaffold(
                            body: Center(
                              child: Text("Some Error Occurred"),
                            ),
                          )));
                });
              }
              return App.of(context).connectionManager.socketState ==
                      SocketState.CONNECTING
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SimpleInputField(
                          validator: (s) => s.trim().isEmpty
                              ? "Name Can't Be Empty"
                              : s.contains(r"#")
                                  ? "Name can't contain #"
                                  : null,
                          onSubmit: (s) {
                            App.of(context)
                                .connectionManager
                                .sendHello("$s#${Uuid().v4()}");
                          },
                          controller: _controller,
                          label: "Your Name",
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Observer(builder: (context) {
                          if (App.of(context).connectionManager.socketState ==
                              SocketState.CONNECTED) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (c) => ChatScreen()));
                            });
                          }
                          return App.of(context)
                                      .connectionManager
                                      .socketState ==
                                  SocketState.CONNECTING
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : FlatButton(
                                  child: Text("Continue"),
                                  onPressed: () {
                                    if (_controller.text.trim().isNotEmpty)
                                      App.of(context).connectionManager.sendHello(
                                          "${_controller.text}#${Uuid().v4()}");
                                  },
                                );
                        })
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
