import 'dart:io';

import 'package:flutter/cupertino.dart';

class FilePasser extends ChangeNotifier {
  late File _file;

  void setFile(File inputFile) {
    this._file = inputFile;
    notifyListeners();
  }

  File? getFile() {
    if (this._file == null) {
      return null;
    }
    return this._file;
  }
}
