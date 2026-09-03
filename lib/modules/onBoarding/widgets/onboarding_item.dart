import 'package:flutter/material.dart';

import '../../../core/app_colors/app_colors.dart';
import 'onboarding_bottom_card.dart';
import 'onboarding_model.dart';
import 'onboarding_welcome_page.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel model;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  const OnBoardingItem({
    super.key,
    required this.model,
    required this.isLast,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    if (model.isWelcome) {
      return OnBoardingWelcomePage(
        model: model,
        onNext: onNext,
      );
    }

    final screenHeight = MediaQuery.sizeOf(context).height;
    final scale = screenHeight / kDesignFrameHeight;
    final imageHeight = screenHeight * model.imageHeightFactor;
    final imageTop = model.imageTopOffset * scale;
    final overlayColor = model.overlayColor ?? AppColors.darkBackground;

    return Container(
      color: AppColors.darkBackground,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: imageTop,
            left: 0,
            right: 0,
            height: imageHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  model.image,
                  fit: BoxFit.cover,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, overlayColor],
                      stops: const [0.35, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: OnBoardingBottomCard(
              model: model,
              isLast: isLast,
              onNext: onNext,
              onBack: onBack,
              onFinish: onFinish,
            ),
          ),
        ],
      ),
    );
  }
}
