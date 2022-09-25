class MatchingProfile {
  bool? success;
  List<User>? user;
  String? message;

  MatchingProfile({this.success, this.user, this.message});

  MatchingProfile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? id;
  int? ageYears;
  int? ageMonths;
  String? birthDateTime;
  String? gender;
  String? maritalStatus;
  String? height;
  String? weight;
  String? religion;
  String? motherTongue;
  String? cast;
  String? education;
  String? occupation;
  String? addressLivingIn;
  String? annualIncome;
  String? location;
  String? photo;
  String? membrType;
  String? memType;
  String? interest;
  String? memberType;

  User(
      {this.id,
        this.ageYears,
        this.ageMonths,
        this.birthDateTime,
        this.gender,
        this.maritalStatus,
        this.height,
        this.weight,
        this.religion,
        this.motherTongue,
        this.cast,
        this.education,
        this.occupation,
        this.addressLivingIn,
        this.annualIncome,
        this.location,
        this.photo,
        this.membrType,
        this.memType,
        this.interest,
        this.memberType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ageYears = json['age_years'];
    ageMonths = json['age_months'];
    birthDateTime = json['birth_date_time'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    weight = json['weight'];
    religion = json['religion'];
    motherTongue = json['mother_tongue'];
    cast = json['cast'];
    education = json['education'];
    occupation = json['occupation'];
    addressLivingIn = json['address_living_in'];
    annualIncome = json['annual_income'];
    location = json['location'];
    photo = json['photo'];
    membrType = json['membr_type'];
    memType = json['mem_type'];
    interest = json['interest'];
    memberType = json['member_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['age_years'] = this.ageYears;
    data['age_months'] = this.ageMonths;
    data['birth_date_time'] = this.birthDateTime;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['religion'] = this.religion;
    data['mother_tongue'] = this.motherTongue;
    data['cast'] = this.cast;
    data['education'] = this.education;
    data['occupation'] = this.occupation;
    data['address_living_in'] = this.addressLivingIn;
    data['annual_income'] = this.annualIncome;
    data['location'] = this.location;
    data['photo'] = this.photo;
    data['membr_type'] = this.membrType;
    data['mem_type'] = this.memType;
    data['interest'] = this.interest;
    data['member_type'] = this.memberType;
    return data;
  }
}
