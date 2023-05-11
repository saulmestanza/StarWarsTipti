import 'package:flutter/material.dart';
import 'package:star_wars/models/films_model.dart';
import 'package:star_wars/services/film_service.dart';

enum FilmState {
  Uninitialized,
  Refreshing,
  Initial_Fetching,
  More_Fetching,
  Fetched,
  No_More_Data,
  Error
}

class FilmController extends ChangeNotifier {
  FilmState _dataState = FilmState.Uninitialized;
  FilmState get dataState => _dataState;
  List<FilmsModel> _dataList = [];
  List<FilmsModel> get dataList => _dataList;

  fetchData(List<String> filmList) async {
    _dataState = FilmState.Refreshing;
    notifyListeners();
    try {
      for (String url in filmList) {
        FilmsModel filmsModel = await FilmService().getFilm(url);
        _dataList.add(filmsModel);
        notifyListeners();
      }

      _dataState = FilmState.Fetched;
      notifyListeners();
    } catch (e) {
      _dataState = FilmState.Error;
    }
  }
}
