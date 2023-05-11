import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_wars/models/films_model.dart';

class FilmService {
  Future<FilmsModel> getFilm(url) async {
    FilmsModel filmsModel = FilmsModel();
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = const Utf8Decoder().convert(response.bodyBytes);
      filmsModel = filmsModelFromJson(body);
    }
    return filmsModel;
  }
}
