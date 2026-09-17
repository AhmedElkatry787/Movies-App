import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/app_colors/app_colors.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int selectedIndex = 0;

  final List<String> languages = [
    'assets/icons/LR.svg',
    'assets/icons/EG.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.yellow,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLanguage(
            index: 0,
          ),
          _buildLanguage(
            index: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguage({
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
            color: AppColors.yellow,
            width: 1,
          )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ClipOval(
            child: SvgPicture.asset(
              languages[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}