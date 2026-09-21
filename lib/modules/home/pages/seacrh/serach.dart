import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../../core/widgets/textfromfield_model.dart';
import '../../../../movies/presentation/manager/injection.dart';
import '../../../../movies/presentation/manager/search_bloc.dart';
import '../../../../movies/presentation/manager/search_event.dart';
import '../../../../movies/presentation/manager/search_state.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildSearchBloc(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  static const Duration _debounce = Duration(milliseconds: 400);

  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    setState(() {});
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, () {
      if (!mounted) return;
      context.read<SearchBloc>().add(SearchQueryChanged(query));
    });
  }

  void _clearQuery() {
    _debounceTimer?.cancel();
    _controller.clear();
    setState(() {});
    context.read<SearchBloc>().add(const SearchCleared());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 21, 16, 12),
              child: CustomTextFormField(
                controller: _controller,
                hintText: 'Search',
                prefixIcon: Icons.search,
                fillColor: AppColors.darkGrey,
                borderRadius: 15,
                height: 57,
                onChanged: _onQueryChanged,
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _clearQuery,
                        icon: const Icon(Icons.close, color: AppColors.white, size: 21),
                      ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.yellow),
                    );
                  }
                  if (state is SearchError) {
                    return _message(state.message);
                  }
                  if (state is SearchLoaded) {
                    if (state.movies.isEmpty) {
                      return _message('No movies match "${state.query}"');
                    }
                    return _moviesGrid(state);
                  }
                  return _message('Search for a movie');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moviesGrid(SearchLoaded state) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: state.movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 189 / 279,
      ),
      itemBuilder: (context, index) => MovieCard(movie: state.movies[index]),
    );
  }

  Widget _message(String text) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/Empty 1.png', width: 120, height: 120),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
