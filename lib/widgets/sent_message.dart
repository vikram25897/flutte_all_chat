import 'package:chat/models/message.dart';
import 'package:chat/res/colors.dart';
import 'package:flutter/material.dart';

class SentMessage extends StatelessWidget {
  final Message message;

  const SentMessage(this.message);

  @override
  Widget build(BuildContext context) {
    bool hori = MediaQuery.of(context).size.width>MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          constraints:
              BoxConstraints(maxWidth:hori ?MediaQuery.of(context).size.width*0.75*0.8: MediaQuery.of(context).size.width * 0.8),
          padding: EdgeInsets.only(left: 10, bottom: 20, top: 8, right: 10),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.zero,
                bottomRight: Radius.circular(20)),
          ),
          child: Text(message.data,style:TextStyle(
            color: Colors.white
          ),),
    ));
  }
}
