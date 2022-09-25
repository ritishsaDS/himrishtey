class PlainsModel {
  bool? success;
  List<Memberships>? memberships;
  String? message;

  PlainsModel({this.success, this.memberships, this.message});

  PlainsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['memberships'] != null) {
      memberships = <Memberships>[];
      json['memberships'].forEach((v) {
        memberships!.add(new Memberships.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.memberships != null) {
      data['memberships'] = this.memberships!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Memberships {
  String? id;
  String? membershipType;
  String? planName;
  String? durationDays;
  String? viewContact;
  String? viewProfile;
  String? liveChat;
  String? personalMessage;
  String? planCost;
  String? offer;
  String? discountPercentage;
  String? points;
  String? hidden;

  Memberships(
      {this.id,
        this.membershipType,
        this.planName,
        this.durationDays,
        this.viewContact,
        this.viewProfile,
        this.liveChat,
        this.personalMessage,
        this.planCost,
        this.offer,
        this.discountPercentage,
        this.points,
        this.hidden});

  Memberships.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    membershipType = json['membership_type'];
    planName = json['plan_name'];
    durationDays = json['duration_days'];
    viewContact = json['view_contact'];
    viewProfile = json['view_profile'];
    liveChat = json['live_chat'];
    personalMessage = json['personal_message'];
    planCost = json['plan_cost'];
    offer = json['offer'];
    discountPercentage = json['discount_percentage'];
    points = json['points'];
    hidden = json['hidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['membership_type'] = this.membershipType;
    data['plan_name'] = this.planName;
    data['duration_days'] = this.durationDays;
    data['view_contact'] = this.viewContact;
    data['view_profile'] = this.viewProfile;
    data['live_chat'] = this.liveChat;
    data['personal_message'] = this.personalMessage;
    data['plan_cost'] = this.planCost;
    data['offer'] = this.offer;
    data['discount_percentage'] = this.discountPercentage;
    data['points'] = this.points;
    data['hidden'] = this.hidden;
    return data;
  }
}
