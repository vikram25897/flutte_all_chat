import 'package:chat/models/message.dart';
import 'package:chat/res/colors.dart';
import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  final Message message;

  const ReceivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    bool hori = MediaQuery.of(context).size.width>MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          constraints:
          BoxConstraints(maxWidth: hori ?MediaQuery.of(context).size.width*0.75*0.8: MediaQuery.of(context).size.width * 0.8),
          padding: EdgeInsets.only(left: 10, bottom: 20, top: 8, right: 10),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.zero,
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message.data,style: TextStyle(
                 color: Colors.white
              ),),
            ],
          )),
    );
  }
}
