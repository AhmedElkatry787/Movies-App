import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';
import '../../../../../movies/domain/entities/movie_details_entity.dart';

class DetailsInfoSection extends StatelessWidget {
  final MovieDetailsEntity movie;

  const DetailsInfoSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                'Watch',
                style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatChip(icon: Icons.favorite, value: '${movie.likeCount}')),
              const SizedBox(width: 16),
              Expanded(child: _StatChip(icon: Icons.watch_later, value: '${movie.runtime}')),
              const SizedBox(width: 16),
              Expanded(child: _StatChip(icon: Icons.star_rounded, value: '${movie.rating}')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatChip({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.yellow, size: 26),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
