import 'dart:convert';

AnnualIncomeModel annualIncomeModelFromJson(String str) =>
    AnnualIncomeModel.fromJson(json.decode(str));

String annualIncomeModelToJson(AnnualIncomeModel data) =>
    json.encode(data.toJson());

class AnnualIncomeModel {
  AnnualIncomeModel({
    this.success,
    this.annualIncomes,
  });

  bool? success;
  List<AnnualIncome>? annualIncomes;

  factory AnnualIncomeModel.fromJson(Map<String, dynamic> json) =>
      AnnualIncomeModel(
        success: json["success"],
        annualIncomes: List<AnnualIncome>.from(
            json["Annual Incomes"].map((x) => AnnualIncome.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Annual Incomes":
            List<dynamic>.from(annualIncomes!.map((x) => x.toJson())),
      };
}

class AnnualIncome {
  AnnualIncome({
    required this.id,
    required this.annualIncome,
    required this.displayOrder,
  });

  String id;
  String annualIncome;
  var displayOrder;

  factory AnnualIncome.fromJson(Map<String, dynamic> json) => AnnualIncome(
        id: json["id"],
        annualIncome: json["annual_income"],
        displayOrder: json["display_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "annual_income": annualIncome,
        "display_order": displayOrder,
      };
}
