import 'package:flutter/material.dart';

/// Height (in design points) of the Figma onboarding frame the per-page
/// image measurements below were taken from.
const double kDesignFrameHeight = 932;

class OnBoardingModel {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final bool isWelcome;
  final double imageHeightFactor;
  final double imageTopOffset;
  final Color? overlayColor;

  const OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
    this.buttonText = 'Next',
    this.isWelcome = false,
    this.imageHeightFactor = 1.0,
    this.imageTopOffset = 0,
    this.overlayColor,
  });
}
