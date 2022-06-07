import 'dart:convert';

import 'package:credibooktest/shared/endpoints.dart';
import 'package:http/http.dart' as http;

class MovieDetailService {
  fetchMovieDetail(int id) async {
    var url = Uri.parse("${Endpoints.movieDetailsPath}$id?api_key=${Endpoints.apikey}&language=en-US");
    print('MOVIE Details : $url');
    http.Response response = await http.get(url);
    var decodeResponse = json.decode(response.body);
    print('BODY RESPONSE : ${response.body}');
    return decodeResponse;
  }
}
