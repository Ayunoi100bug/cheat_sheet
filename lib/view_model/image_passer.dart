import 'package:flutter/cupertino.dart';

class ImagePasser extends ChangeNotifier {
  late Image image;

  void setImage(Image inputImage) {
    this.image = inputImage;
  }

  Image getImage() {
    return this.image;
  }
}
