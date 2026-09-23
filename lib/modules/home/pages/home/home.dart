import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/home/pages/home/widgets/category_section.dart';
import 'package:movies_app/modules/home/pages/home/widgets/hero_carousel.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../movies/domain/entities/movie_entity.dart';
import '../../../../movies/presentation/manager/injection.dart';
import '../../../../movies/presentation/manager/movies_bloc.dart';
import '../../../../movies/presentation/manager/movies_event.dart';
import '../../../../movies/presentation/manager/movies_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildMoviesBloc()..add(const MoviesRequested()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  static const int _minMoviesPerSection = 3;

  double _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading || state is MoviesInitial) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: AppColors.yellow)),
          );
        }
        if (state is MoviesError) {
          return Scaffold(
            backgroundColor: AppColors.darkBackground,
            body: Center(
              child: Text(state.message, style: const TextStyle(color: AppColors.white)),
            ),
          );
        }

        final movies = (state as MoviesLoaded).movies;
        final heroMovies = movies.take(5).toList();

        final moviesByGenre = <String, List<MovieEntity>>{};
        for (final movie in movies) {
          for (final genre in movie.genres) {
            moviesByGenre.putIfAbsent(genre, () => []).add(movie);
          }
        }

        final genres = moviesByGenre.keys
            .where((genre) => moviesByGenre[genre]!.length >= _minMoviesPerSection)
            .toList()
          ..sort((a, b) => moviesByGenre[b]!.length.compareTo(moviesByGenre[a]!.length));

        final activeIndex = _currentPage.round().clamp(
          0,
          heroMovies.isNotEmpty ? heroMovies.length - 1 : 0,
        );
        final currentHeroMovie = heroMovies.isNotEmpty ? heroMovies[activeIndex] : null;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              if (currentHeroMovie != null)
                Positioned.fill(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(currentHeroMovie.posterUrl, fit: BoxFit.cover),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 7),
                      Center(child: Image.asset('assets/images/Available Now.png', height: context.scaled(90))),
                      const SizedBox(height: 21),
                      if (heroMovies.isNotEmpty)
                        HeroCarousel(
                          movies: heroMovies,
                          onPageChanged: (page) => setState(() => _currentPage = page),
                        ),
                      const SizedBox(height: 21),
                      Center(child: Image.asset('assets/images/Watch Now.png', height: context.scaled(150))),
                      const SizedBox(height: 7),
                      for (final genre in genres)
                        CategorySection(
                          title: genre,
                          movies: moviesByGenre[genre]!,
                        ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}