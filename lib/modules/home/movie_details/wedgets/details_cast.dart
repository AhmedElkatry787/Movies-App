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
    // Grows past the design's 90px when a long name wraps on a narrow screen.
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 90),
      margin:  EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(10),
              image: member.imageUrl != null
                  ? DecorationImage(image: NetworkImage(member.imageUrl!), fit: BoxFit.cover)
                  : null,
            ),
            child: member.imageUrl == null
                ? const Icon(Icons.person, color: AppColors.white)
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${member.name}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 20)),
                Text('Character: ${member.characterName}', style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}