// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.success,
    required this.message,
  //  required this.errorMessage,
  });

  bool success;
  String message;
  //String errorMessage;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    success: json["success"],
    message: json["message"],
    //errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    //"errorMessage": errorMessage,
  };
}
