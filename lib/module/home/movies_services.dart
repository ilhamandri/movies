import 'dart:convert';

import 'package:credibooktest/shared/endpoints.dart';
import 'package:http/http.dart' as http;

class MoviesServices {
  fetchMovies(int page) async {
    var url = Uri.parse(Endpoints.movieListEndpoint + Endpoints.apikey + '&language=en-US&page=$page');
    print('MOVIE URL : $url');
    http.Response response = await http.get(url);
    var decodeResponse = json.decode(response.body);
    print('BODY RESPONSE : ${response.body}');
    return decodeResponse;
  }
}
