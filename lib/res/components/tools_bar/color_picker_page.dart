import 'package:cheat_sheet/view_model/color_passer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';

class ColorPickerPage extends StatefulWidget {
  final Color pickedColor;
  final PainterController controller;
  const ColorPickerPage({super.key, required this.pickedColor, required this.controller});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenWidth * 0.3,
            ),
            ColorPicker(
              pickerColor: widget.pickedColor,
              onColorChanged: (Color c) {
                Provider.of<ColorPasser>(context, listen: false).setColor(c);
                widget.controller.drawColor = c;
              },
            ),
            SizedBox(
              height: screenWidth * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
