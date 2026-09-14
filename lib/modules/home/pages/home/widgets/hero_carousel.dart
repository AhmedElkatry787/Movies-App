import 'package:flutter/material.dart';
import 'rating_badge.dart';

class HeroCarousel extends StatefulWidget {
  final List<dynamic> movies;
  final ValueChanged<double>? onPageChanged;

  const HeroCarousel({super.key, required this.movies, this.onPageChanged});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.62);
    _controller.addListener(() {
      final page = _controller.page ?? 0;
      setState(() => _currentPage = page);
      widget.onPageChanged?.call(page);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          final difference = (_currentPage - index).abs();
          final scale = (1 - (difference * 0.25)).clamp(0.75, 1.0);

          return Transform.scale(
            scale: scale,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
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
                  Positioned(top: 12, left: 12, child: RatingBadge(rating: movie.rating)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}