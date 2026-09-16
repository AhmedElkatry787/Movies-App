import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';

class DetailsScreenshots extends StatelessWidget {
  final List<String> screenshots;

  const DetailsScreenshots({super.key, required this.screenshots});

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: screenshots.map((url) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: AppColors.darkGrey),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
