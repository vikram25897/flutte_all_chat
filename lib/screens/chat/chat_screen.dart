import 'package:chat/routes/routes.dart';
import 'package:chat/sockets/connection_manager.dart';
import 'package:chat/screens/chat/actual_chat_screen.dart';
import 'package:chat/widgets/contact_list.dart';
import 'package:chat/widgets/orientation_aware_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ConnectionManager cm = App.of(context).connectionManager;
    return OrientationAwareWidget(
      landscape: Scaffold(
        appBar: AppBar(
          title: Text(cm.activeMember==-1?"Click On A User To Chat":cm.members[cm.activeMember].name),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ContactList(),
            ),
            Expanded(
              flex: 3,
              child: ActualChat(),
            ),
          ],
        ),
      ),
      portrait: Scaffold(
        appBar: AppBar(
          title: Text(cm.activeMember==-1?"Click On A User To Chat":cm.members[cm.activeMember].name),
        ),
        drawer: ContactList(),
        body: ActualChat(),
      ),
    );
  }
}