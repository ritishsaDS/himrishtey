class PopUpData {
  bool? success;
  List<Offers>? offers;
  String? message;

  PopUpData({this.success, this.offers, this.message});

  PopUpData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Offers {
  String? id;
  String? title;
  String? description;
  String? image;
  String? offerDate;
  String? status;
  String? offerTime;

  Offers(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.offerDate,
        this.status,
        this.offerTime});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    offerDate = json['offer_date'];
    status = json['status'];
    offerTime = json['offer_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['offer_date'] = this.offerDate;
    data['status'] = this.status;
    data['offer_time'] = this.offerTime;
    return data;
  }
}
