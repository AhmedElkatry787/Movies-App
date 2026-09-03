import 'package:flutter/material.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../model/buttom_model.dart';
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
    return Container(
      color: AppColors.darkBackground,
      child: Column(
        children: [
          Expanded(
            flex: 5,
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
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16,33),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      color: Colors.white.withOpacity(0.6),
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
        ],
      ),
    );
  }
}
