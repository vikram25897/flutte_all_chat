import 'package:flutter/material.dart';

class OrientationAwareWidget extends StatelessWidget{
  final Widget landscape;
  final Widget portrait;
  const OrientationAwareWidget({Key key,@required this.landscape,@required this.portrait}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.width>=size.height ? landscape : portrait;
  }
}