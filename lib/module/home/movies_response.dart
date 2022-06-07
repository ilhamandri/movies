import 'package:credibooktest/module/details/movie_model.dart';

class MoviesResponse {
  int? page;
  int? total_pages;
  int? total_results;
  List<MovieModel>? movies;

  MoviesResponse({this.movies, this.total_pages, this.page, this.total_results});

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    var movie_list = json['results'] as List;
    List<MovieModel> m = movie_list.map((element) => MovieModel.fromJson(element)).toList();
    return MoviesResponse(
      page: json['page'],
      movies: m,
      total_pages: json['total_pages'],
      total_results: json['total_results'],
    );
  }
}
