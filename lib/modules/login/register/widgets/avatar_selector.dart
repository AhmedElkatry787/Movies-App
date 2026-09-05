import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarSelector extends StatefulWidget {
  final Function(int index) onAvatarSelected;
  const AvatarSelector({super.key, required this.onAvatarSelected});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  int centerIndex = 0;
  final List<String> avatars =
  List.generate(9, (i) => 'assets/icons/p${i + 1}.svg');

  void _select(int newCenter) {
    setState(() {
      centerIndex = newCenter % avatars.length;
    });
    widget.onAvatarSelected(centerIndex);
  }

  @override
  Widget build(BuildContext context) {
    final int leftIndex = (centerIndex - 1 + avatars.length) % avatars.length;
    final int rightIndex = (centerIndex + 1) % avatars.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _avatarCircle(index: leftIndex, size: 75, onTap: () => _select(leftIndex)),
            _avatarCircle(index: centerIndex, size: 125, isSelected: true, onTap: () {}),
            _avatarCircle(index: rightIndex, size: 75, onTap: () => _select(rightIndex)),
          ],
        ),
        const SizedBox(height: 5),
        const Text(
          'Avatar',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _avatarCircle({
    required int index,
    required double size,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: const Color(0xff9C35FF), width: 3)
              : null,
        ),
        child: SvgPicture.asset(avatars[index], fit: BoxFit.cover),
      ),
    );
  }
}