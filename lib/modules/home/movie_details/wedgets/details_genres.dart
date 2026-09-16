import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';

class DetailsGenres extends StatelessWidget {
  final List<String> genres;

  const DetailsGenres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: genres.map((genre) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(genre, style: const TextStyle(color: AppColors.white, fontSize: 13)),
          );
        }).toList(),
      ),
    );
  }
}