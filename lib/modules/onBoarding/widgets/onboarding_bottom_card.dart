import 'package:flutter/material.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../core/widgets/buttom_model.dart';
import 'onboarding_model.dart';

const double kCardHeightFactor = 0.36;

class OnBoardingBottomCard extends StatelessWidget {
  final OnBoardingModel model;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  const OnBoardingBottomCard({
    super.key,
    required this.model,
    required this.isLast,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * kCardHeightFactor,
      ),
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 34, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 66),
              child: Text(
                model.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: isLast ? 'Finish' : model.buttonText,
              onPressed: isLast ? onFinish : onNext,
              height: 55,
              fontSize: 20,
              borderRadius: 12,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.yellow),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
