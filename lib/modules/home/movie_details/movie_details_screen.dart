import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_backdrop.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_cast.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_genres.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_info_section.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_screenshots.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_similar.dart';
import 'package:movies_app/modules/home/movie_details/wedgets/details_summary.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../movies/presentation/manager/injection.dart';
import '../../../../movies/presentation/manager/movie_details_bloc.dart';
import '../../../../movies/presentation/manager/movie_details_event.dart';
import '../../../../movies/presentation/manager/movie_details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildMovieDetailsBloc()..add(MovieDetailsRequested(movieId)),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading || state is MovieDetailsInitial) {
            return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
          }
          if (state is MovieDetailsError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: AppColors.white)),
            );
          }

          final loaded = state as MovieDetailsLoaded;
          final movie = loaded.movie;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsBackdrop(movie: movie),
                DetailsInfoSection(movie: movie),
                _sectionTitle('Screen Shots'),
                DetailsScreenshots(screenshots: movie.screenshots),
                if (loaded.similarMovies.isNotEmpty) ...[
                  _sectionTitle('Similar'),
                  DetailsSimilar(movies: loaded.similarMovies),
                ],
                _sectionTitle('Summary'),
                DetailsSummary(summary: movie.summary),
                _sectionTitle('Cast'),
                DetailsCast(cast: movie.cast),
                _sectionTitle('Genres'),
                DetailsGenres(genres: movie.genres),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}