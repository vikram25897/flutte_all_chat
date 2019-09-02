import 'package:chat/routes/routes.dart';
import 'package:chat/sockets/connection_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DrawerP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectionManager cm = App.of(context).connectionManager;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 2)
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                      width: 100,
                      height: 100,
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        cm.name.split("#")[0],
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                      ))),
                ),
                SizedBox(height: 20,),
                Text("Active Users",style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.w600
                ),),
                Expanded(
                  child: Observer(builder: (context) {
                    return ListView.builder(
                        itemCount: cm.members.length,
                        itemBuilder: (c, i) => InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                cm.setActiveChat(i);
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: i == cm.activeMember ? Colors.grey : Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(cm.members[i].name.split("#")[0]),
                              ),
                            ));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
