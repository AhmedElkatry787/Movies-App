import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';

class DetailsSummary extends StatelessWidget {
  final String summary;

  const DetailsSummary({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        summary,
        style: TextStyle(color: AppColors.white, fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
      ),
    );
  }
}