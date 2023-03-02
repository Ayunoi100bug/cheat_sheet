import 'package:cheat_sheet/res/components/tools_bar/color_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:painter/painter.dart';

import '../../colors.dart';

class ToolsPaintBar extends StatelessWidget {
  final PainterController controller;
  final double screenWidth;
  final double screenHeight;
  final bool isPortrait;
  const ToolsPaintBar({super.key, required this.controller, required this.screenWidth, required this.screenHeight, required this.isPortrait});

  @override
  Widget build(BuildContext context) {
    bool isEraserMode = false;
    Color color = AppColors.black700.withOpacity(0.5);
    return Row(
      children: [
        SizedBox(
          width: isPortrait ? screenWidth * 0.012 : screenHeight * 0.1,
        ),
        InkWell(
          onTap: () {
            if (!controller.isEmpty) {
              controller.undo();
            }
          },
          child: Icon(
            Icons.undo,
            size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
            color: AppColors.black700,
          ),
        ),
        SizedBox(
          width: isPortrait ? screenWidth * 0.04 : screenHeight * 0.2,
        ),
        ColorPickerButton(controller: controller, screenWidth: screenWidth, screenHeight: screenHeight, isPortrait: isPortrait),
        SizedBox(
          width: isPortrait ? screenWidth * 0.04 : screenHeight * 0.2,
        ),
        StatefulBuilder(
          builder: (BuildContext context, setState) {
            return InkWell(
              onTap: () {
                setState(() {
                  if (!isEraserMode) {
                    color = AppColors.black700;
                  } else if (isEraserMode) {
                    color = AppColors.black700.withOpacity(0.5);
                  }
                  isEraserMode = !isEraserMode;
                  controller.eraseMode = !controller.eraseMode;
                });
              },
              child: Icon(
                FontAwesomeIcons.eraser,
                size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
                color: color,
              ),
            );
          },
        ),
        SizedBox(
          width: isPortrait ? screenWidth * 0.056 : screenHeight * 0.22,
        ),
        InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.delete,
            size: isPortrait ? screenHeight * 0.036 : screenWidth * 0.044,
            color: AppColors.black700,
          ),
        ),
        SizedBox(
          width: isPortrait ? screenWidth * 0.044 : screenHeight * 0.44,
        ),
        StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Slider(
              value: controller.thickness,
              onChanged: (value) => {
                setState(() {
                  controller.thickness = value;
                })
              },
              min: 1.0,
              max: 20.0,
              activeColor: AppColors.primary500,
              inactiveColor: AppColors.black300,
            );
          },
        ),
      ],
    );
  }
}
