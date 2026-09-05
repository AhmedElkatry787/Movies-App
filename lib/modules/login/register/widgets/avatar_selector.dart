import 'package:flutter/material.dart';

class AvatarSelector extends StatefulWidget {
  final Function(int index) onAvatarSelected;
  const AvatarSelector({super.key, required this.onAvatarSelected});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  int centerIndex = 0;
  final List<String> avatars =
  List.generate(9, (i) => 'assets/images/p${i + 1}.png');

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
            _avatarCircle(index: leftIndex, size: 95, onTap: () => _select(leftIndex)),
            _avatarCircle(index: centerIndex, size: 150, isSelected: true, onTap: () {}),
            _avatarCircle(index: rightIndex, size: 95, onTap: () => _select(rightIndex)),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Avatar',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
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
        ),
        child: Image.asset(avatars[index], fit: BoxFit.cover),
      ),
    );
  }
}