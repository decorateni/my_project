class Movie {
  final String title;
  final String? posterPath;
  final double voteAverage;

  Movie({
    required this.title,
    this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] as String? ?? 'Unknown Title', // Безпечне приведення
      posterPath: json['poster_path'] as String?,        // Допустимий `null`
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0, // Безпечне приведення
    );
  }
}
