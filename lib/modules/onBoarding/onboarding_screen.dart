import 'package:flutter/material.dart';
import 'package:movies_app/core/cache/app_prefs.dart';
import 'package:movies_app/core/routes/app_routes_name.dart';
import 'widgets/onboarding_item.dart';
import 'widgets/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  static const List<OnBoardingModel> _pages = [
    OnBoardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Find Your Next Favorite Movie Here',
      description:
          'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      buttonText: 'Explore Now',
      isWelcome: true,
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Discover Movies',
      description:
          'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      imageHeightFactor: 710 / kDesignFrameHeight,
      overlayColor:  Color(0xFF084250),
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Explore All Genres',
      description:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      imageHeightFactor: 668 / kDesignFrameHeight,
      overlayColor:  Color(0xFF85210E),
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding4.png',
      title: 'Create Watchlists',
      description:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      imageHeightFactor: 750 / kDesignFrameHeight,
      overlayColor:  Color(0xFF4C2471),
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding5.png',
      title: 'Rate, Review, and Learn',
      description:
          'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      imageHeightFactor: 752 / kDesignFrameHeight,
      imageTopOffset: -11,
      overlayColor:  Color(0xFF601321),
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding6.png',
      title: 'Start Watching Now',
      description:
          'Your movie journey starts here. Browse, save and enjoy thousands of films whenever you want.',
      imageHeightFactor: 680 / kDesignFrameHeight,
      overlayColor:  Color(0xFF2A2C30),
    ),
  ];

  void _goToNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    await AppPrefs.setOnBoardingSeen();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutesName.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return OnBoardingItem(
            model: _pages[index],
            isLast: index == _pages.length - 1,
            onNext: _goToNext,
            onBack: _goToBack,
            onFinish: _finish,
          );
        },
      ),
    );
  }
}
