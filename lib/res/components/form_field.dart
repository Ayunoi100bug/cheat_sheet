import 'package:flutter/material.dart';

import '../colors.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;

  MyTextFormField({
    super.key,
    this.hintText,
    this.helperText,
    required this.autovalidateMode,
    required this.validator,
    required this.onSaved,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.black800, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.black800, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.error500, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.error500, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        hintText: hintText,
        helperText: helperText,
        isDense: true,
      ),
      style: TextStyle(fontSize: 14),
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: onSaved,
    );
  }
}

class MyTextFormFieldLarge extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;

  MyTextFormFieldLarge({
    super.key,
    this.hintText,
    this.helperText,
    required this.autovalidateMode,
    required this.validator,
    required this.onSaved,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.black800, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.black800, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.error500, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.error500, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        // contentPadding: EdgeInsets.only(
        //     bottom: isPortrait ? screenWidth * 0.36 : screenWidth * 0.05),
        hintText: hintText,
        helperText: helperText,
        isDense: true,
      ),
      style: TextStyle(fontSize: 14),
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: onSaved,
      maxLines: null,
    );
  }
}
