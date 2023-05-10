// To parse this JSON data, do
//
//     final PeopleModel = PeopleModelFromJson(jsonString);

import 'dart:convert';

import 'package:star_wars/models/films_model.dart';

PeopleModel PeopleModelFromJson(String str) =>
    PeopleModel.fromJson(json.decode(str));

String PeopleModelToJson(PeopleModel data) => json.encode(data.toJson());

class PeopleModel {
  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeworld;
  List<String>? films;
  List<FilmsModel>? filmsModel;

  PeopleModel({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.filmsModel,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        name: json["name"] ?? "",
        height: json["height"] ?? "",
        mass: json["mass"] ?? "",
        hairColor: json["hair_color"] ?? "",
        skinColor: json["skin_color"] ?? "",
        eyeColor: json["eye_color"] ?? "",
        birthYear: json["birth_year"] ?? "",
        gender: json["gender"] ?? "",
        homeworld: json["homeworld"] ?? "",
        films: json["films"] == null
            ? []
            : List<String>.from(json["films"]?.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "gender": gender,
        "homeworld": homeworld,
        "films": films == null ? [] : List<dynamic>.from(films!.map((x) => x)),
      };
}
