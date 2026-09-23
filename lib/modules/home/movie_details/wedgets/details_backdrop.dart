import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_colors/app_colors.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../movies/domain/entities/movie_details_entity.dart';
import '../../../../../movies/domain/entities/movie_entity.dart';
import '../../../../../watchlist/presentation/manager/watchlist_bloc.dart';
import '../../../../../watchlist/presentation/manager/watchlist_event.dart';
import '../../../../../watchlist/presentation/manager/watchlist_state.dart';

class DetailsBackdrop extends StatelessWidget {
  final MovieDetailsEntity movie;

  const DetailsBackdrop({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.posterUrl.isNotEmpty ? movie.posterUrl : movie.backdropUrl;
    final screen = MediaQuery.sizeOf(context);
    // Capped so tablets and landscape phones still see the page below it.
    final height = math.min(screen.width * 1.45, screen.height * 0.75);

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
                    _WatchlistButton(movie: movie),
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

class _WatchlistButton extends StatelessWidget {
  final MovieDetailsEntity movie;

  const _WatchlistButton({required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchlistBloc, WatchlistState>(
      listenWhen: (previous, current) => current.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      builder: (context, state) {
        final isSaved = state.contains(movie.id);

        return IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: isSaved ? AppColors.yellow : AppColors.white,
            size: 28,
          ),
          onPressed: state.isLoading
              ? null
              : () => context.read<WatchlistBloc>().add(WatchlistToggled(
                    MovieEntity(
                      id: movie.id,
                      title: movie.title,
                      year: movie.year,
                      rating: movie.rating,
                      genres: movie.genres,
                      posterUrl: movie.posterUrl,
                      summary: movie.summary,
                    ),
                  )),
        );
      },
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    final size = context.scaled(100);

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.06),
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12)],
      ),
      child: Container(
        decoration: const BoxDecoration(color: AppColors.yellow, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Container(
          width: size * 0.48,
          height: size * 0.48,
          decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
          child: Icon(Icons.play_arrow_rounded, color: AppColors.yellow, size: size * 0.4),
        ),
      ),
    );
  }
}
