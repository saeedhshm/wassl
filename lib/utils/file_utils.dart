import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';


class FileUtility {
  static Future<String> writeFileToDirectory(
      Uint8List imgBytes, String fileName) async {
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;


    Directory directory = Directory('$appDocPath/WaslFiles');
    await directory.create(recursive: true);
    final file = File('${directory.path}/$fileName.pdf');

    await file.create();

    await file.writeAsBytes(imgBytes);
    return file.path;
  }

  static Future renameFolder(String oldName, String newName) async {
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;
    Directory directory = Directory('$appDocPath/$oldName');
    return directory.rename('$appDocPath/$newName');
  }

  static Future deleteDire(String direUri) async {
    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;
    Directory directory = Directory('$appDocPath/$direUri/');

    return await directory.delete(recursive: true);
  }

  static Future<Uint8List> readFileFromDirector(String dire) async {
    final file = File(dire);
    await file.open();
    return file.readAsBytes();
  }

  static Future<FileSystemEntity> deleteFile(String fileUri) async {
    final file = File(fileUri);
    return await file.delete();
  }
}
