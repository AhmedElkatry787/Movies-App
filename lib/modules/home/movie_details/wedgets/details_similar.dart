import 'package:flutter/material.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../../movies/domain/entities/movie_entity.dart';

class DetailsSimilar extends StatelessWidget {
  final List<MovieEntity> movies;

  const DetailsSimilar({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) => MovieCard(movie: movies[index]),
    );
  }
}
