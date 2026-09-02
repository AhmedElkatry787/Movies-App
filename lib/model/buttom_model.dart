import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Color borderColor;
  final Color fillColor;
  final Color hintColor;
  final Color textColor;
  final double borderRadius;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.borderColor = Colors.white,
    this.fillColor = Colors.transparent,
    this.hintColor = Colors.grey,
    this.textColor = Colors.white,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        filled: true,
        fillColor: fillColor,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}