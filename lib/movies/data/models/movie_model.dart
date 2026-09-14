import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.genres,
    required super.posterUrl,
    required super.summary,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      rating: (json['rating'] as num? ?? 0).toDouble(),
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((g) => g.toString())
          .toList(),
      posterUrl: json['medium_cover_image'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
    );
  }
}