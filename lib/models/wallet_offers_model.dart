class WalletOffers {
  bool? success;
  Number? number;
  String? message;

  WalletOffers({this.success, this.number, this.message});

  WalletOffers.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    number =
    json['number'] != null ? new Number.fromJson(json['number']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.number != null) {
      data['number'] = this.number!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Number {
  String? id;
  String? title;
  String? amount;
  String? addOnPercentage;
  String? description;
  String? status;
  int? finalAmount;

  Number(
      {this.id,
        this.title,
        this.amount,
        this.addOnPercentage,
        this.description,
        this.status,
        this.finalAmount});

  Number.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    addOnPercentage = json['add_on_percentage'];
    description = json['description'];
    status = json['status'];
    finalAmount = json['final_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['add_on_percentage'] = this.addOnPercentage;
    data['description'] = this.description;
    data['status'] = this.status;
    data['final_amount'] = this.finalAmount;
    return data;
  }
}
