import 'package:cheat_sheet/data/network/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class ToImageWidget {
  static Future<Image> toImage(PictureDetails picture) async {
    return Image.memory(await picture.toPNG());
  }
}
