import 'package:flutter/material.dart';
import 'package:star_wars/models/people_model.dart';
import 'package:star_wars/models/people_paginated_model.dart';
import 'package:star_wars/services/people_service.dart';

enum DataState {
  Uninitialized,
  Refreshing,
  Initial_Fetching,
  More_Fetching,
  Fetched,
  No_More_Data,
  Error
}

class PeopleController extends ChangeNotifier {
  int _currentPageNumber = 1;
  DataState _dataState = DataState.Uninitialized;
  bool _didLastLoad = false;
  DataState get dataState => _dataState;
  List<PeopleModel> _dataList = [];
  List<PeopleModel> get dataList => _dataList;

  fetchData({bool isRefresh = false}) async {
    if (!isRefresh) {
      _dataState = (_dataState == DataState.Uninitialized)
          ? DataState.Initial_Fetching
          : DataState.More_Fetching;
    } else {
      _currentPageNumber = 1;
      _dataState = DataState.Refreshing;
    }
    notifyListeners();
    try {
      if (_didLastLoad) {
        _dataState = DataState.No_More_Data;
      } else {
        PeoplePaginatedModel peoplePaginatedModel =
            await PeopleService().getAll(_currentPageNumber);
        if (_dataState == DataState.Refreshing) {
          _dataList.clear();
        }
        _dataList += peoplePaginatedModel.results!;
        _didLastLoad = peoplePaginatedModel.next == null;
        _dataState = DataState.Fetched;
        _currentPageNumber++;
      }
      notifyListeners();
    } catch (e) {
      print(e);
      _dataState = DataState.Error;
      notifyListeners();
    }
  }
}
