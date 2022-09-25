import 'dart:convert';

OccupationModel occupationModelFromJson(String str) =>
    OccupationModel.fromJson(json.decode(str));

String occupationModelToJson(OccupationModel data) =>
    json.encode(data.toJson());

class OccupationModel {
  OccupationModel({
    this.success,
    this.occupations,
  });

  bool? success;
  List<Occupation>? occupations;

  factory OccupationModel.fromJson(Map<String, dynamic> json) =>
      OccupationModel(
        success: json["success"],
        occupations: List<Occupation>.from(
            json["Occupations"].map((x) => Occupation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Occupations": List<dynamic>.from(occupations!.map((x) => x.toJson())),
      };
}

class Occupation {
  Occupation({
    required this.id,
    required this.occupation,
  });

  String id;
  String occupation;

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
        id: json["id"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "occupation": occupation,
      };
}
