import 'package:flutter/material.dart';

import '../core/app_colors/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.fillColor = AppColors.darkBackground,
    this.textColor = AppColors.white,
    this.hintColor = AppColors.white,
    this.borderRadius = 10,
    this.height = 45,
    this.contentPadding,
  });

  final TextEditingController? controller;

  final String? hintText;
  final String? labelText;

  final IconData? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  final bool enabled;
  final bool readOnly;

  final Color fillColor;
  final Color textColor;
  final Color hintColor;

  final double borderRadius;
  final double height;

  final EdgeInsetsGeometry? contentPadding;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,

        obscureText: _isObscured,

        keyboardType: widget.keyboardType,

        validator: widget.validator,

        onChanged: widget.onChanged,

        onTap: widget.onTap,

        enabled: widget.enabled,

        readOnly: widget.readOnly,

        style: TextStyle(
          color: widget.textColor,
          fontSize: 12,
        ),

        cursorColor: widget.textColor,

        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,

          hintText: widget.hintText,
          labelText: widget.labelText,

          hintStyle: TextStyle(
            color: widget.hintColor,
            fontSize: 12,
          ),

          labelStyle: TextStyle(
            color: widget.hintColor,
            fontSize: 12,
          ),

          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(
            widget.prefixIcon,
            color: AppColors.white,
            size: 21,
          ),

          suffixIcon: widget.obscureText
              ? IconButton(
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            icon: Icon(
              _isObscured
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.white,
              size: 21,
            ),
          )
              : widget.suffixIcon,

          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}