import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AppFilesManager {
  AppFilesManager();

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
      } else {
        throw 'File does not exist.';
      }
    } catch (e) {
      throw 'Error while deleting file: $e';
    }
  }

  Future<List<File>> getSavedExcelFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path).listSync();
    List<File> savedExcelFiles = [];

    for (var file in files) {
      if (file is File && extension(file.path) == '.xlsx') {
        savedExcelFiles.add(file);
      }
    }

    return savedExcelFiles;
  }
}