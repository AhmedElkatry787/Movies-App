import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/app_colors/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      'assets/icons/home.svg',
      'assets/icons/search.svg',
      'assets/icons/browse.svg',
      'assets/icons/profile.svg',
    ];

    return Container(
      // Also clears the system navigation bar / home indicator and landscape notches.
      margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 9) +
          MediaQuery.paddingOf(context).copyWith(top: 0),
      height: 61,
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = selectedIndex == index;
          return InkWell(
            onTap: () => onItemTapped(index),
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                icons[index],
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.yellow : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}