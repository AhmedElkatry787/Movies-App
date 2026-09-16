import 'package:flutter/material.dart';
import '../../../../../core/app_colors/app_colors.dart';
import '../../../../../movies/domain/entities/cast_member_entity.dart';

class DetailsCast extends StatelessWidget {
  final List<CastMemberEntity> cast;

  const DetailsCast({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: cast.map((member) => _CastRow(member: member)).toList(),
      ),
    );
  }
}

class _CastRow extends StatelessWidget {
  final CastMemberEntity member;

  const _CastRow({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.darkBackground,
            backgroundImage: member.imageUrl != null ? NetworkImage(member.imageUrl!) : null,
            child: member.imageUrl == null ? const Icon(Icons.person, color: AppColors.white) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${member.name}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
                Text('Character: ${member.characterName}', style: TextStyle(color: AppColors.white.withOpacity(0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}