import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:star_wars/models/films_model.dart';
import 'package:star_wars/services/film_service.dart';

import 'film_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late FilmService service;

  setUp(() {
    mockClient = MockClient();
    service = FilmService();
  });

  final uri = Uri.parse('https://swapi.dev/api/films/1');
  const jsonString = """
  {
  "title": "A New Hope"
}
  """;
  final film = FilmsModel(title: "A new Hope");

  test('should return film with success when status code is 200', () async {
    // arrange
    when(mockClient.get(uri))
        .thenAnswer((_) async => http.Response(jsonString, 200));
    // act
    final result = await service.getFilm("https://swapi.dev/api/films/1");
    // assert
    expect(result, equals(film));
    verify(mockClient.get(uri));
  });

  test('should throw an error when status code is not 200', () async {
    // arrange
    when(mockClient.get(uri)).thenAnswer((_) async => http.Response('', 404));
    // act
    final call = await service.getFilm("https://swapi.dev/api/films/1");
    // assert
    expect(call, equals(FilmsModel()));
    verify(mockClient.get(uri));
  });
}
