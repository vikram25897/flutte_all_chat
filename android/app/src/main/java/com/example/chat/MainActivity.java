package com.example.chat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;

import androidx.core.app.ActivityCompat;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.io.File;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    File dir = new File(Environment.getExternalStorageDirectory() + "/GeekyChat/");
    if (ActivityCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
      ActivityCompat.requestPermissions(this, new String[]{
              Manifest.permission.WRITE_EXTERNAL_STORAGE
      }, 841);
    } else {
      Log.e("dir", dir.getAbsolutePath());
      if (!dir.exists())
        if (dir.mkdirs()) {
          Log.e("director", "created");
        } else Log.e("directory", "not created");
    }
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
    File dir = new File(Environment.getExternalStorageDirectory() + "/GeekyChat/");
    if(requestCode==841 && grantResults[0] == PackageManager.PERMISSION_GRANTED){
      Log.e("dir", dir.getAbsolutePath());
      if (!dir.exists())
        if (dir.mkdirs()) {
          Log.e("director", "created");
        } else Log.e("directory", "not created");
    }
  }
}
