import 'dart:async';
import 'dart:io';
import 'package:file_chooser/file_chooser.dart';
import 'package:file_picker/file_picker.dart';

class CustomFilePicker {
  pickSingle({FileType fileType, String confirmText = "Select"}) async {
    Completer completer = Completer();
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      showOpenPanel((status, paths) {
        if (status == FileChooserResult.cancel) {
          completer.completeError("cancelled");
        } else
          completer.complete(paths[0]);
      },
          allowedFileTypes: _getFileTypeFromFileTypeEnum(fileType),
          allowsMultipleSelection: false,
          confirmButtonText: confirmText);
    } else {
      FilePicker.getFilePath(type: fileType)
        ..then((s) {
          completer.complete(s);
        })
        ..catchError((e) {
          completer.completeError(e);
        });
    }
    return completer.future;
  }
  List<String> _getFileTypeFromFileTypeEnum(FileType fileType) {
    if (fileType == null) return null;
    switch (fileType) {
      case FileType.ANY:
        return null;
      case FileType.IMAGE:
        return <String>["png", "jpg", "gif", "webp"];
      case FileType.VIDEO:
        return <String>["mp4", "3gp", "mkv", "avi", "m4v"];
      case FileType.AUDIO:
        return <String>["mp3", "wav", "m4a"];
      case FileType.CUSTOM:
        return null;
    }
    return null;
  }
}

CustomFilePicker filePicker = CustomFilePicker();
