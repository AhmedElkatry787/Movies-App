import '../../domain/entities/cast_member_entity.dart';

class CastMemberModel extends CastMemberEntity {
  const CastMemberModel({
    required super.name,
    required super.characterName,
    super.imageUrl,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) {
    return CastMemberModel(
      name: json['name'] as String? ?? '',
      characterName: json['character_name'] as String? ?? '',
      imageUrl: json['url_small_image'] as String?,
    );
  }
}