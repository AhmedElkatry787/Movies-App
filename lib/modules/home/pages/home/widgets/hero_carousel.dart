import 'package:flutter/material.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/widgets/movie_card.dart';

class HeroCarousel extends StatefulWidget {
  final List<dynamic> movies;
  final ValueChanged<double>? onPageChanged;

  const HeroCarousel({super.key, required this.movies, this.onPageChanged});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  /// Page size on the 430px design frame: 62% of its width, 350 tall.
  static const double _designPageWidth = kDesignFrameWidth * 0.62;
  static const double _designHeight = 350;

  PageController? _controller;
  double _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pages keep their design size, so wider screens show more of the posters
    // on either side. A PageController's viewport fraction is fixed, so a
    // rotation that changes it gets a new controller.
    final fraction = context.scaled(_designPageWidth) / MediaQuery.sizeOf(context).width;
    final oldController = _controller;
    if (oldController?.viewportFraction == fraction) return;

    _controller = PageController(viewportFraction: fraction, initialPage: _currentPage.round())
      ..addListener(_onScroll);
    if (oldController != null) {
      oldController.removeListener(_onScroll);
      // Its PageView is only removed later in this frame.
      WidgetsBinding.instance.addPostFrameCallback((_) => oldController.dispose());
    }
  }

  void _onScroll() {
    final page = _controller!.page ?? 0;
    setState(() => _currentPage = page);
    widget.onPageChanged?.call(page);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.scaled(_designHeight),
      child: PageView.builder(
        // A new controller gets a new PageView, not the old scroll position.
        key: ObjectKey(_controller),
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
              child: MovieCard(movie: movie, borderRadius: 20),
            ),
          );
        },
      ),
    );
  }
}
