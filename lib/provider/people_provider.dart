import 'package:flutter/material.dart';
import 'package:star_wars/models/people_model.dart';
import 'package:star_wars/models/people_paginated_model.dart';
import 'package:star_wars/services/people_service.dart';

enum PeopleState {
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
  PeopleState _dataState = PeopleState.Uninitialized;
  bool _didLastLoad = false;
  PeopleState get dataState => _dataState;
  List<PeopleModel> _dataList = [];
  List<PeopleModel> get dataList => _dataList;

  fetchData({bool isRefresh = false, String gender = ""}) async {
    if (!isRefresh) {
      _dataState = (_dataState == PeopleState.Uninitialized)
          ? PeopleState.Initial_Fetching
          : PeopleState.More_Fetching;
    } else if (gender.isNotEmpty || isRefresh) {
      _currentPageNumber = 1;
      _didLastLoad = false;
      _dataState = PeopleState.Refreshing;
    }
    notifyListeners();
    try {
      if (_didLastLoad) {
        _dataState = PeopleState.No_More_Data;
      } else {
        PeoplePaginatedModel peoplePaginatedModel =
            await PeopleService().getAll(_currentPageNumber);
        if (_dataState == PeopleState.Refreshing) {
          _dataList.clear();
        }
        _dataList += gender.isEmpty
            ? peoplePaginatedModel.results!
            : peoplePaginatedModel.results!
                .where((p) => p.gender == gender)
                .toList();
        _didLastLoad = peoplePaginatedModel.next == null;
        _dataState = PeopleState.Fetched;
        _currentPageNumber++;
      }
      notifyListeners();
    } catch (e) {
      _dataState = PeopleState.Error;
      notifyListeners();
    }
  }
}
