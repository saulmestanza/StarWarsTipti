import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:star_wars/models/films_model.dart';
import 'package:star_wars/provider/film_provider.dart';
import 'package:star_wars/services/film_service.dart';
import 'film_provider_test.mocks.dart';

@GenerateMocks([FilmService])
void main() {
  late FilmService service;
  late FilmController provider;
  int listenCount = 0;

  setUp(() {
    listenCount = 0;
    service = FilmService();
    provider = FilmController();
  });

  const jsonString = """
  {
  "title": "A New Hope"
}
  """;
  final FilmsModel film = FilmsModel(title: "A new Hope");
  List<FilmsModel> films = [film];
  String url = "https://swapi.dev/api/films/1";
  test('should change state into success, and film variable should be filled',
      () async {
    // arrange
    when(service.getFilm(url)).thenAnswer((_) async => film);
    // act
    await provider.fetchData([url]);
    // assert
    expect(provider.dataState, equals(FilmState.Fetched));
    expect(provider.dataList, equals([films]));
    expect(listenCount, equals(1));
    verify(service.getFilm(url));
  });

  test('should change state into error', () async {
    // arrange
    when(service.getFilm(url)).thenThrow(Error());
    // act
    await provider.fetchData([url]);
    // assert
    expect(provider.dataState, equals(FilmState.Error));
    expect(listenCount, equals(2));
    verify(service.getFilm(url));
  });
}
