import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';
import '../../../../../movies/domain/entities/movie_details_entity.dart';

class DetailsBackdrop extends StatelessWidget {
  final MovieDetailsEntity movie;

  const DetailsBackdrop({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.posterUrl.isNotEmpty ? movie.posterUrl : movie.backdropUrl;
    final height = MediaQuery.of(context).size.width * 1.45;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: AppColors.darkGrey),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.45, 1.0],
                colors: [
                  AppColors.darkBackground.withOpacity(0.3),
                  AppColors.darkBackground.withOpacity(0.4),
                  AppColors.darkBackground,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 26),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark, color: AppColors.white, size: 28),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Center(child: _PlayButton()),
          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: Column(
              children: [
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${movie.year}',
                  style: const TextStyle(
                    color: Color(0xFFADADAD),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12)],
      ),
      child: Container(
        decoration: const BoxDecoration(color: AppColors.yellow, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
          child: const Icon(Icons.play_arrow_rounded, color: AppColors.yellow, size: 40),
        ),
      ),
    );
  }
}
