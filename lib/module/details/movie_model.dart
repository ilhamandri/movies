class MovieModel {
  final int? id;
  final String? backdrop_path;
  final String? title;
  final String? overview;
  final double? vote_average;

  MovieModel({
    this.id,
    this.backdrop_path,
    this.overview,
    this.title,
    this.vote_average,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        backdrop_path: json['backdrop_path'],
        overview: json['overview'],
        title: json['title'],
        vote_average: json['vote_average'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'backdrop_path': backdrop_path,
        'title': title,
        'overview': overview,
        'vote_average': vote_average,
      };
}
