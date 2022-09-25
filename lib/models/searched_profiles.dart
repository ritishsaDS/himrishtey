class SearchedProfiles {
  bool? success;
  List<User>? user;
  String? message;

  SearchedProfiles({this.success, this.user, this.message});

  SearchedProfiles.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add( User.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class User {
  String? id;
  String? profileId;
  String? gender;
  String? birthDateTime;
  String? height;
  String? religion;
  String? motherTongue;
  String? cast;
  String? education;
  String? occupation;
  String? addressLivingIn;
  String? location;
  String? photo;

  User(
      {this.id,
        this.gender,
        this.birthDateTime,
        this.height,
        this.religion,
        this.motherTongue,
        this.cast,
        this.education,
        this.profileId,
        this.occupation,
        this.addressLivingIn,
        this.location,
        this.photo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    birthDateTime = json['birth_date_time'];
    height = json['height'];
    religion = json['religion'];
    motherTongue = json['mother_tongue'];
    cast = json['cast']; profileId = json['profile_id'];
    education = json['education'];
    occupation = json['occupation'];
    addressLivingIn = json['address_living_in'];
    location = json['location'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gender'] = gender;
    data['birth_date_time'] = birthDateTime;
    data['profile_id'] = profileId;
    data['height'] = height;
    data['religion'] = religion;
    data['mother_tongue'] = motherTongue;
    data['cast'] = cast;
    data['education'] = education;
    data['occupation'] = occupation;
    data['address_living_in'] = addressLivingIn;
    data['location'] = location;
    data['photo'] = photo;
    return data;
  }
}
