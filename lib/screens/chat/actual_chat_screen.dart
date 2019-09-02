import 'package:chat/models/message.dart';
import 'package:chat/routes/routes.dart';
import 'package:chat/sockets/connection_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../widgets/message_bubble.dart';

class ActualChat extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNodeTemp = FocusNode();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ConnectionManager connectionManager = App.of(context).connectionManager;
    return Observer(builder: (context) {
      List<Message> messages;
      if(connectionManager.activeMember != -1 &&
          connectionManager.activeMember < connectionManager.members.length)
      messages = connectionManager.currentMessages;
      return connectionManager.activeMember == -1 ||
              connectionManager.activeMember >= connectionManager.members.length
          ? Center(
              child: Text("No Chat Selected"),
            )
          : Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        child: ListView.builder(
                      itemCount: messages.length > 0 ? messages.length : 0,
                      reverse: true,
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: EdgeInsets.all(12.0),
                          child:
                              MessageBubble(messages[messages.length - i - 1]),
                        );
                      },
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.zero,
                          child: TextFormField(
                            controller: textController,
                            maxLines: 3,
                            minLines: 1,
                            enableInteractiveSelection: false,
                            textInputAction: TextInputAction.send,
                            onFieldSubmitted: (s) {
                              print(textController.text);
                              if (s.trim().length != 0) {
                                connectionManager.sendMessage(s.trim());
                                FocusScope.of(context)
                                    .requestFocus(focusNodeTemp);
                                textController.clear();
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2))),
                            focusNode: focusNode,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_file,size: 40,),
                        onPressed: (){
                          connectionManager.sendFile();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
