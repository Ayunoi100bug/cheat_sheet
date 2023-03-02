import 'package:cheat_sheet/res/colors.dart';
import 'package:flutter/cupertino.dart';

class ColorPasser extends ChangeNotifier {
  Color _color = AppColors.black700;

  void setColor(Color inputColor) {
    this._color = inputColor;
    notifyListeners();
  }

  Color getColor() {
    return this._color;
  }

  void reset() {
    this._color = AppColors.black700;
    notifyListeners();
  }
}
