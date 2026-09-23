import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../../movies/presentation/manager/injection.dart';
import '../../../../movies/presentation/manager/movies_bloc.dart';
import '../../../../movies/presentation/manager/movies_event.dart';
import '../../../../movies/presentation/manager/movies_state.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildMoviesBloc()..add(const MoviesRequested()),
      child: const _BrowseView(),
    );
  }
}

class _BrowseView extends StatefulWidget {
  const _BrowseView();

  @override
  State<_BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<_BrowseView> {
  String? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading || state is MoviesInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
            }
            if (state is MoviesError) {
              return Center(
                child: Text(state.message, style: const TextStyle(color: AppColors.white)),
              );
            }
        
            final movies = (state as MoviesLoaded).movies;
        
            final genres = <String>{};
            for (final movie in movies) {
              genres.addAll(movie.genres);
            }
            final genreList = genres.toList()..sort();
        
            _selectedGenre ??= genreList.isNotEmpty ? genreList.first : null;
        
            final filteredMovies = _selectedGenre == null
                ? movies
                : movies.where((m) => m.genres.contains(_selectedGenre)).toList();
        
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: genreList.length,
                    itemBuilder: (context, index) {
                      final genre = genreList[index];
                      final isSelected = genre == _selectedGenre;
                      return Padding(
                        padding:  EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedGenre = genre),
                          child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.yellow : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.yellow,
                              ),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: isSelected ? Colors.black : AppColors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredMovies.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 240,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.62,
                    ),
                    itemBuilder: (context, index) {
                      return MovieCard(movie: filteredMovies[index]);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}