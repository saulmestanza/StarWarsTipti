// To parse this JSON data, do
//
//     final filmsModel = filmsModelFromJson(jsonString);

import 'dart:convert';

FilmsModel filmsModelFromJson(String str) =>
    FilmsModel.fromJson(json.decode(str));

String filmsModelToJson(FilmsModel data) => json.encode(data.toJson());

class FilmsModel {
  String? title;

  FilmsModel({
    this.title,
  });

  factory FilmsModel.fromJson(Map<String, dynamic> json) => FilmsModel(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
