import 'dart:convert';

EmployerModel employerModelFromJson(String str) =>
    EmployerModel.fromJson(json.decode(str));

String employerModelToJson(EmployerModel data) => json.encode(data.toJson());

class EmployerModel {
  EmployerModel({
    this.success,
    this.employers,
  });

  bool? success;
  List<Employer>? employers;

  factory EmployerModel.fromJson(Map<String, dynamic> json) => EmployerModel(
        success: json["success"],
        employers: List<Employer>.from(
            json["Employers"].map((x) => Employer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Employers": List<dynamic>.from(employers!.map((x) => x.toJson())),
      };
}

class Employer {
  Employer({
    required this.id,
    required this.employer,
  });

  String id;
  String employer;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json["id"],
        employer: json["employer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer": employer,
      };
}
