import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? child;
  final IconData? icon;
  final String? svgIcon;
  final String? imageIcon;
  final double iconSize;
  final double iconSpacing;
  final bool iconAfterText;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 50,
    this.backgroundColor = const Color(0xffFFC107),
    this.textColor = Colors.black,
    this.borderRadius = 8,
    this.fontSize = 20,
    this.fontWeight = FontWeight.w600,
    this.child,
    this.icon,
    this.svgIcon,
    this.imageIcon,
    this.iconSize = 22,
    this.iconSpacing = 8,
    this.iconAfterText = false,
  });

  Widget? _buildIcon() {
    if (svgIcon != null) {
      return SvgPicture.asset(
        svgIcon!,
        width: iconSize,
        height: iconSize,
      );
    }
    if (imageIcon != null) {
      return Image.asset(
        imageIcon!,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
      );
    }

    // Flutter Icon
    if (icon != null) {
      return Icon(
        icon,
        size: iconSize,
        color: textColor,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final buttonIcon = _buildIcon();

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,

          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),

        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (buttonIcon != null && !iconAfterText) ...[
                  buttonIcon,
                  SizedBox(width: iconSpacing),
                ],

                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor,
                    letterSpacing: 0,
                    height: 1.0,
                  ),
                ),

                if (buttonIcon != null && iconAfterText) ...[
                  SizedBox(width: iconSpacing),
                  buttonIcon,
                ],
              ],
            ),
      ),
    );
  }
}