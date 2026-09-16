class CastMemberEntity {
  final String name;
  final String characterName;
  final String? imageUrl;

  const CastMemberEntity({
    required this.name,
    required this.characterName,
    this.imageUrl,
  });
}