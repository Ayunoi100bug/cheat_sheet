import 'package:flutter/material.dart';

import '../colors.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;

  MyTextFormField({
    super.key,
    this.hintText,
    this.helperText,
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
          borderSide: BorderSide(
              width: 1, color: AppColors.black800, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: AppColors.black800, style: BorderStyle.solid),
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
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: onSaved,
    );
  }
}
