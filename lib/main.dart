import 'dart:io';

import 'package:chat/res/values.dart';
import 'package:chat/routes/routes.dart';
import 'package:file_chooser/file_chooser.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
void main(){
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  setBasePath();
  routes();
}

void setBasePath() async{
  if(Platform.isIOS || Platform.isAndroid){
    basePath = (await getExternalStorageDirectory()).path+"/GeekyChat/";
  } else if(Platform.isMacOS)
    basePath = "/Users/vikram/Desktops/GeekyChat/";
}

