import 'package:chat/res/colors.dart';
import 'package:chat/widgets/orientation_aware_widget.dart';
import 'package:chat/widgets/portrait/drawer.dart';
import 'package:flutter/material.dart';
import 'landscape/drawer.dart';

class ContactList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return OrientationAwareWidget(
      portrait: DrawerP(),
      landscape: DrawerL(),
    );
  }
}