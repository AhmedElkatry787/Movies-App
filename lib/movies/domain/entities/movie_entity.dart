class MovieEntity {
  final int id;
  final String title;
  final int year;
  final double rating;
  final List<String> genres;
  final String posterUrl;
  final String summary;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.posterUrl,
    required this.summary,
  });
}