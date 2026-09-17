import 'package:flutter/material.dart';
import '../../modules/home/movie_details/movie_details_screen.dart';
import '../../movies/domain/entities/movie_entity.dart';
import '../app_colors/app_colors.dart';
import 'rating_badge.dart';


class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final double? width;
  final double? height;
  final double borderRadius;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movie,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId: movie.id)),
              ),
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: AppColors.darkGrey),
              ),
              Positioned(top: 8, left: 8, child: RatingBadge(rating: movie.rating)),
            ],
          ),
        ),
      ),
    );
  }
}
