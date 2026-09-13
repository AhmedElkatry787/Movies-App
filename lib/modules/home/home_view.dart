import 'package:flutter/material.dart';
import 'package:movies_app/core/app_colors/app_colors.dart';
import 'package:movies_app/modules/home/pages/browse.dart';
import 'package:movies_app/modules/home/pages/home.dart';
import 'package:movies_app/modules/home/pages/profile.dart';
import 'package:movies_app/modules/home/pages/serach.dart';
import 'package:movies_app/modules/home/wigets/bottom_navgation_bar.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  final List<Widget> pages = const [
    Home(),
    Search(),
    Browse(),
    Profile(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,

        body: PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),


        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: (int index) {  setState(() {
            selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ); },
        ),
      ),
    );
  }
}