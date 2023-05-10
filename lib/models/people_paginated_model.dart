// To parse this JSON data, do
//
//     final peoplePaginatedModel = peoplePaginatedModelFromJson(jsonString);

import 'dart:convert';

import 'package:star_wars/models/people_model.dart';

PeoplePaginatedModel peoplePaginatedModelFromJson(String str) =>
    PeoplePaginatedModel.fromJson(json.decode(str));

String peoplePaginatedModelToJson(PeoplePaginatedModel data) =>
    json.encode(data.toJson());

class PeoplePaginatedModel {
  int? count;
  String? next;
  dynamic previous;
  List<PeopleModel>? results;

  PeoplePaginatedModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PeoplePaginatedModel.fromJson(Map<String, dynamic> json) =>
      PeoplePaginatedModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<PeopleModel>.from(
                json["results"]!.map((x) => PeopleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}
