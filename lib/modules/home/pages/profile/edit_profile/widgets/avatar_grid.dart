import 'package:flutter/material.dart';
import '../../../../../../core/app_colors/app_colors.dart';

class AvatarGrid extends StatelessWidget {
  static const int avatarCount = 9;

  static const double panelPadding = 16;
  static const double panelRadius = 16;
  static const double tileSpacing = 20;
  static const double tileRadius = 20;
  static const double tileWidth = 108;
  static const double tileHeight = 105;

  static const Color selectedFill = Color(0x8FF6BD00);

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AvatarGrid({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static String assetFor(int index) => 'assets/images/p${index + 1}.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(panelPadding),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(panelRadius),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: avatarCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: tileSpacing,
          crossAxisSpacing: tileSpacing,
          childAspectRatio: tileWidth / tileHeight,
        ),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelected(index),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isSelected ? selectedFill : Colors.transparent,
                borderRadius: BorderRadius.circular(tileRadius),
              ),
              child: Image.asset(assetFor(index), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
