import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_wars/models/people_paginated_model.dart';

class PoepleService {
  Future<PeoplePaginatedModel> getAll() async {
    PeoplePaginatedModel paginatedModel = PeoplePaginatedModel();
    final uri = Uri.parse("https://swapi.dev/api/people");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = const Utf8Decoder().convert(response.bodyBytes);
      paginatedModel = peoplePaginatedModelFromJson(body);
    }
    return paginatedModel;
  }
}
