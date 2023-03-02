import 'package:auto_route/auto_route.dart';
import 'package:cheat_sheet/utils/routes/routes.gr.dart';
import 'package:cheat_sheet/view_model/color_passer.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';

class ColorPickerButton extends StatefulWidget {
  final PainterController controller;
  final double screenWidth;
  final double screenHeight;
  final bool isPortrait;
  const ColorPickerButton({super.key, required this.controller, required this.screenWidth, required this.screenHeight, required this.isPortrait});

  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _pickColor(context);
      },
      child: Icon(
        Icons.brush,
        size: widget.isPortrait ? widget.screenHeight * 0.036 : widget.screenWidth * 0.044,
        color: Provider.of<ColorPasser>(context).getColor(),
      ),
    );
  }

  void _pickColor(BuildContext context) {
    AutoRouter.of(context).push(PickColorRoute(pickedColor: widget.controller.drawColor, controller: widget.controller));
  }
}
