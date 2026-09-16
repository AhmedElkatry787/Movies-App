import 'cast_member_entity.dart';

class MovieDetailsEntity {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String posterUrl;
  final String backdropUrl;
  final int likeCount;
  final List<String> screenshots;
  final List<CastMemberEntity> cast;

  const MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.posterUrl,
    required this.backdropUrl,
    required this.likeCount,
    required this.screenshots,
    required this.cast,
  });
}