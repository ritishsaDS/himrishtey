class GetMemberships {
  bool? success;
  List<Memberships>? memberships;
  String? message;

  GetMemberships({this.success, this.memberships, this.message});

  GetMemberships.fromJson(Map<String, dynamic> json) {
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
  String? membershipName;
  String? durationDays;
  String? viewProfileviewContact;
  String? viewProfile;
  String? planCost;
  String? discountPercentage;
  String? planDescription;
  String? tagLine1;
  String? tagLine2;
  String? tagLine3;
  String? tagLine4;
  String? tagLine5;
  String? tagLine6;

  Memberships(
      {this.id,
        this.membershipName,
        this.durationDays,
        this.viewProfileviewContact,
        this.viewProfile,
        this.planCost,
        this.discountPercentage,
        this.planDescription,
        this.tagLine1,
        this.tagLine2,
        this.tagLine3,
        this.tagLine4,
        this.tagLine5,
        this.tagLine6});

  Memberships.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    membershipName = json['membership_name'];
    durationDays = json['duration_days'];
    viewProfileviewContact = json['view_profileview_contact'];
    viewProfile = json['view_profile'];
    planCost = json['plan_cost'];
    discountPercentage = json['discount_percentage'];
    planDescription = json['plan_description'];
    tagLine1 = json['tag_line1'];
    tagLine2 = json['tag_line2'];
    tagLine3 = json['tag_line3'];
    tagLine4 = json['tag_line4'];
    tagLine5 = json['tag_line5'];
    tagLine6 = json['tag_line6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['membership_name'] = this.membershipName;
    data['duration_days'] = this.durationDays;
    data['view_profileview_contact'] = this.viewProfileviewContact;
    data['view_profile'] = this.viewProfile;
    data['plan_cost'] = this.planCost;
    data['discount_percentage'] = this.discountPercentage;
    data['plan_description'] = this.planDescription;
    data['tag_line1'] = this.tagLine1;
    data['tag_line2'] = this.tagLine2;
    data['tag_line3'] = this.tagLine3;
    data['tag_line4'] = this.tagLine4;
    data['tag_line5'] = this.tagLine5;
    data['tag_line6'] = this.tagLine6;
    return data;
  }
}
