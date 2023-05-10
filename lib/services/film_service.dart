import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_wars/models/films_model.dart';

class CharacterService {
  Future<FilmsModel> getFilm(id) async {
    FilmsModel filmsModel = FilmsModel();
    final uri = Uri.parse("https://swapi.dev/api/films/$id/");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = const Utf8Decoder().convert(response.bodyBytes);
      filmsModel = filmsModelFromJson(body);
    }
    return filmsModel;
  }
}
