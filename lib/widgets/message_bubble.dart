import 'package:chat/models/message.dart';
import 'package:chat/res/colors.dart';
import 'package:chat/widgets/received_message.dart';
import 'package:chat/widgets/sent_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    switch (message.messageType) {
      case MessageType.SENT:
        return SentMessage(message);
      case MessageType.RECEIVED:
        return ReceivedMessage(message);
      case MessageType.FILE_SENT:
        return FileSentMessage(
          message: message,
        );
      case MessageType.FILE_RECEIVED:
        return FileReceivedMessage(message: message,);
    }
    return SizedBox();
  }
}

class FileSentMessage extends StatelessWidget {
  final Message message;

  const FileSentMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hori = MediaQuery.of(context).size.width>MediaQuery.of(context).size.height;
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: hori ?MediaQuery.of(context).size.width*0.75*0.8:MediaQuery.of(context).size.width * 0.7),
          padding: EdgeInsets.only(left: 10, bottom: 20, top: 8, right: 10),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.zero,
                bottomRight: Radius.circular(20)),
          ),
          child: Center(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
              title: Text("File Sent",style: TextStyle(color: Colors.white),),
              subtitle: Text(message.data,style: TextStyle(color: Colors.white),),
              trailing: Text(message.messageId,style: TextStyle(color: Colors.white),),
            ),
          ),
        ));
  }
}
class FileReceivedMessage extends StatelessWidget {
  final Message message;

  const FileReceivedMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hori = MediaQuery.of(context).size.width>MediaQuery.of(context).size.height;
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints:
          BoxConstraints(maxWidth: hori ?MediaQuery.of(context).size.width*0.75*0.8:MediaQuery.of(context).size.width * 0.7),
          padding: EdgeInsets.only(left: 10, bottom: 20, top: 8, right: 10),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.zero,
                bottomRight: Radius.circular(20)),
          ),
child: Center(
  child:   ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
    title: Text("File Received",style: TextStyle(color: Colors.white),),
    subtitle: Text(message.data,style: TextStyle(color: Colors.white),),
    trailing: Text(message.messageId,style: TextStyle(color: Colors.white),),
  ),
),
//          child: Column(
//            children: <Widget>[
//              Text(
//                message.data,
//                style:
//                TextStyle(color: Colors.white),
//              ),
//              Text(
//                  "Size: "+message.messageId,style: TextStyle(color: Colors.white),
//              )
//            ],
//          ),
        ));
  }
}
