import 'package:cheat_sheet/res/typo.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class Tag extends StatefulWidget {
  final String subject;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final double size;
  final IconData? icon;
  final double iconSize;

  final void Function() onPressed;
  const Tag(
      {super.key,
      required this.subject,
      this.color = AppColors.orange100,
      this.textcolor = AppColors.orange600,
      this.height = 44,
      this.width = 116,
      this.size = 14,
      this.icon,
      this.iconSize = 18,
      required this.onPressed});

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: MaterialButton(
        height: isPortrait ? screenHeight * 0.03 : screenHeight * 0.015,
        minWidth: isPortrait ? screenHeight * 0.01 : screenHeight * 0.015,
        color: widget.color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Regular16px(
              text: widget.subject,
              color: widget.textcolor,
              size: widget.size,
            ),
            if (widget.icon != null) ...[
              Align(
                child: Icon(
                  widget.icon,
                  color: widget.textcolor,
                  size: widget.iconSize,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class SelectTag extends StatefulWidget {
  final String subject;
  final Color color;
  final Color textcolor;
  final double height;
  final double width;
  final double size;
  final bool? isChecked;
  final void Function() onPressed;
  final subjectTypeOne = [
    'วิทยาศาสตร์',
    'คณิตศาสตร์',
    'สังคม',
    'ภาษา',
    'สุขศึกษา',
    'ประวัติศาสตร์',
    'ศิลปะ',
    'ดนตรี',
    'พระพุทธศาสนา',
  ];

  SelectTag({
    super.key,
    required this.subject,
    required this.onPressed,
    this.color = AppColors.orange100,
    this.textcolor = AppColors.orange600,
    this.height = 44,
    this.width = 116,
    this.size = 14,
    this.isChecked,
  });

  @override
  State<SelectTag> createState() => _SelectTagState();
}

class _SelectTagState extends State<SelectTag> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        children: [
          MaterialButton(
            height: isPortrait ? screenHeight * 0.03 : screenHeight * 0.015,
            minWidth: isPortrait ? screenHeight * 0.01 : screenHeight * 0.015,
            color: widget.color,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {},
                    side: const BorderSide(
                      color: AppColors.orange500,
                      width: 1,
                    ),
                    checkColor: AppColors.orange500,
                    activeColor: Colors.transparent,
                  ),
                ),
                Regular16px(
                  text: widget.subject,
                  color: widget.textcolor,
                  size: widget.size,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
                widget.onPressed();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
