import '../../domain/entities/movie_details_entity.dart';
import 'cast_member_model.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
    required super.summary,
    required super.posterUrl,
    required super.backdropUrl,
    required super.screenshots,
    required super.cast,
    required super.likeCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final screenshots = [
      json['large_screenshot_image1'],
      json['large_screenshot_image2'],
      json['large_screenshot_image3'],
    ].whereType<String>().toList();

    final castJson = json['cast'] as List<dynamic>? ?? [];

    return MovieDetailsModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      rating: (json['rating'] as num? ?? 0).toDouble(),
      runtime: json['runtime'] as int? ?? 0,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((g) => g.toString())
          .toList(),
      summary: json['description_full'] as String? ?? '',
      posterUrl: json['large_cover_image'] as String? ?? '',
      backdropUrl: json['background_image'] as String? ?? '',
      likeCount: json['like_count'] as int? ?? 0,
      screenshots: screenshots,
      cast: castJson
          .map((c) => CastMemberModel.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}