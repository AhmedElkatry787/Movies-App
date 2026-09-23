import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/widgets/movie_card.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<dynamic> movies;

  const CategorySection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    final cardWidth = context.scaled(110);
    final cardHeight = context.scaled(220);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('See More →', style: TextStyle(color: AppColors.yellow)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: MovieCard(movie: movies[index], width: cardWidth, height: cardHeight, borderRadius: 14),
              );
            },
          ),
        ),
      ],
    );
  }
}