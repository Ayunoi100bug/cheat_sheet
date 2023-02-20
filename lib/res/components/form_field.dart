import 'package:flutter/material.dart';

import '../colors.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final int maxLine;
  final int minLine;
  final double fontSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  MyTextFormField({
    super.key,
    this.hintText,
    this.helperText,
    required this.autovalidateMode,
    required this.validator,
    this.onSaved,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.initialValue,
    this.obscureText = false,
    this.enabled = true,
    this.maxLine = 1,
    this.minLine = 1,
    this.fontSize = 14,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
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
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.black800, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.error500, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.error500, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,
        helperText: helperText,
        isDense: true,
      ),
      style: TextStyle(fontSize: fontSize),
      validator: validator,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: obscureText,
      enabled: enabled,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      maxLines: maxLine,
      minLines: minLine,
    );
  }
}
