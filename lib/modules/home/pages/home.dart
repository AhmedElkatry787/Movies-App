import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/presentation/manager/injection.dart';
import '../../../movies/presentation/manager/movies_bloc.dart';
import '../../../movies/presentation/manager/movies_event.dart';
import '../../../movies/presentation/manager/movies_state.dart';
import '../../../core/app_colors/app_colors.dart';

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
  final PageController _heroController = PageController(viewportFraction: 0.62);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _heroController.addListener(() {
      setState(() => _currentPage = _heroController.page ?? 0);
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
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
        final heroMovies = movies.take(5).toList();
        final actionMovies = movies.where((m) => m.genres.contains('Action')).toList();

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Home', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                Center(child: Image.asset('assets/images/Available Now.png', height: 40)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 320,
                  child: heroMovies.isEmpty
                      ? const SizedBox()
                      : PageView.builder(
                    controller: _heroController,
                    itemCount: heroMovies.length,
                    itemBuilder: (context, index) {
                      final movie = heroMovies[index];
                      final difference = (_currentPage - index).abs();
                      final scale = (1 - (difference * 0.25)).clamp(0.75, 1.0);

                      return Transform.scale(
                        scale: scale,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  movie.posterUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 12,
                                left: 12,
                                child: _RatingBadge(rating: movie.rating),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),
                Center(child: Image.asset('assets/images/Watch Now.png', height: 50)),
                const SizedBox(height: 24),

                // عنوان التصنيف + See More
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Action',
                          style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          // TODO: هنوصلها بتاب الـ Browse بعدين
                        },
                        child: const Text('See More →', style: TextStyle(color: AppColors.yellow)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // قائمة أفقية لأفلام الأكشن
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: actionMovies.length,
                    itemBuilder: (context, index) {
                      final movie = actionMovies[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 110,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  movie.posterUrl,
                                  width: 110,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: _RatingBadge(rating: movie.rating),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: AppColors.yellow, size: 14),
        ],
      ),
    );
  }
}