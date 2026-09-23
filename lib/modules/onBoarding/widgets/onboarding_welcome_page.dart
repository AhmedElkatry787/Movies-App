import 'package:flutter/material.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/buttom_model.dart';
import 'onboarding_model.dart';

class OnBoardingWelcomePage extends StatelessWidget {
  final OnBoardingModel model;
  final VoidCallback onNext;

  const OnBoardingWelcomePage({
    super.key,
    required this.model,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      color: AppColors.darkBackground,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(model.image, fit: BoxFit.cover),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppColors.darkBackground],
                      stops: [0.6, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The text keeps the design's bottom 3/8 of the screen, and takes
          // more from the image when it needs it on short screens. Only past
          // 60% of the screen does it scroll.
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight * 3 / 8,
              maxHeight: screenHeight * 0.6,
            ),
            child: Align(
              heightFactor: 1,
              child: SingleChildScrollView(
                padding: context.contentPadding(horizontal: 16).copyWith(bottom: 33),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      model.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: model.buttonText,
                      onPressed: onNext,
                      height: 48,
                      fontSize: 24,
                      borderRadius: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
