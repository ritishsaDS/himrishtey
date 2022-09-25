// To parse this JSON data, do
//
//     final dashBoardProfilesModel = dashBoardProfilesModelFromJson(jsonString);

import 'dart:convert';

DashBoardProfilesModel dashBoardProfilesModelFromJson(String str) => DashBoardProfilesModel.fromJson(json.decode(str));

String dashBoardProfilesModelToJson(DashBoardProfilesModel data) => json.encode(data.toJson());

class DashBoardProfilesModel {
  DashBoardProfilesModel({
   required this.success,
   required this.user,
   required this.message,
  });

  bool success;
  List<User>? user;
  String message;

  factory DashBoardProfilesModel.fromJson(Map<String, dynamic> json) => DashBoardProfilesModel(
    success: json["success"],
    user: json["user"] == null ? null : List<User>.from(json["user"].map((x) => User.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user": user == null ? null : List<dynamic>.from(user!.map((x) => x.toJson())),
    "message": message,
  };
}

class User {
  User({
  required this.id,
  required this.registrationDate,
  required this.profileId,
  required this.username,
  required this.profileCreatedFor,
  required this.fullName,
  required this.email,
  required this.mobileNumber,
  required this.alternateNumber,
  required this.whatsappNumber,
  required this.birthDateTime,
  required this.password,
  required this.height,
  required this.weight,
  required this.gender,
  required this.bloodGroup,
  required this.healthInfo,
  required this.birthPlace,
  required this.religion,
  required this.motherTongue,
  required this.cast,
  required this.subCast,
  required this.gotra,
  required this.manglik,
  required this.maritalStatus,
  required this.noOfChild,
  required this.aboutMyEducation,
  required this.education,
  required this.anyOtherQualifications,
  required this.aboutMyCareer,
  required this.employedIn,
  required this.occupation,
  required this.designation,
  required this.organizationName,
  required this.jobLocation,
  required this.annualIncome,
  required this.countryLivingIn,
  required this.stateLivingIn,
  required this.cityLivingIn,
  required this.addressLivingIn,
  required this.familyType,
  required this.familyStatus,
  required this.fatherName,
  required this.fatherOccupation,
  required this.motherName,
  required this.motherOccupation,
  required this.noOfBrothers,
  required this.noOfSisters,
  required this.marriedBrothers,
  required this.marriedSisters,
  required this.familyIncome,
  required this.aboutFamily,
  required this.diet,
  required this.isDrinking,
  required this.isSmoking,
  required this.aboutMe,
  required this.anyDisability,
  required this.lookingFor,
  required this.partnerAgeFrom,
  required this.partnerAgeTo,
  required this.partnerCountry,
  required this.partnerReligion,
  required this.partnerCast,
  required this.partnerHeightFrom,
  required this.partnerHeightTo,
  required this.partnerEducation,
  required this.partnerMothertongue,
  required this.partnerAnnualIncome,
  //required this.horoscopeNeeded,
  required this.referralCode,
  required this.idProof,
  required this.photo,
  required this.photoPassword,
  required this.member_type,
  required this.photoApproved,
  required this.active,
  required this.planId,
  required this.planActivationDate,
  required this.profileCompleted,
  required this.promoted,
  required this.remarks,
  required this.interest,
  });

  String? id;
  DateTime ?registrationDate;
  String? profileId;
  String? username;
  String ?profileCreatedFor;
  String ?fullName;
  String ?member_type;
  String ?email;
  dynamic mobileNumber;
  String ?alternateNumber;
  dynamic whatsappNumber;
  String ?birthDateTime;
  String? password;
  String? height;
  String?weight;
  String ?gender;
  String ?bloodGroup;
  String ?healthInfo;
  dynamic birthPlace;
  String ?religion;
  String ?motherTongue;
  String ?cast;
  String ?subCast;
  String ?gotra;
  String ?manglik;
  String ?maritalStatus;
  String?noOfChild;
  String ?aboutMyEducation;
  var education;
  String ?anyOtherQualifications;
  String ?aboutMyCareer;
  String ?employedIn;
  String ?occupation;
  String ?designation;
  String ?organizationName;
  String ?jobLocation;
  String ?annualIncome;
  String ?countryLivingIn;
  String ?stateLivingIn;
  String ?cityLivingIn;
  String ?addressLivingIn;
  String ?familyType;
  String ?familyStatus;
  String ?fatherName;
  String ?fatherOccupation;
  String ?motherName;
  String ?motherOccupation;
  dynamic noOfBrothers;
  dynamic noOfSisters;
  dynamic marriedBrothers;
  dynamic marriedSisters;
  String ?familyIncome;
  String ?aboutFamily;
  String ?diet;
  String ?isDrinking;
  String ?isSmoking;
  String ?aboutMe;
  String ?anyDisability;
  String ?lookingFor;
  String?partnerAgeFrom;
  String?partnerAgeTo;
  String ?partnerCountry;
  String ?partnerReligion;
  String ?partnerCast;
  String?partnerHeightFrom;
  String?partnerHeightTo;
  String ?partnerEducation;
  String ?partnerMothertongue;
  String ?partnerAnnualIncome;
  var referralCode;
  String ?idProof;
  String ?photo;
  String ?photoPassword;
  String ?photoApproved;
  String ?active;
  String?planId;
  DateTime ?planActivationDate;
  String?profileCompleted;
  String ?promoted;
  String ?remarks;
  String ?interest;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    registrationDate: json["registration_date"] == null ? null : DateTime.parse(json["registration_date"]),
    profileId: json["profile_id"],
    username: json["username"],
    interest: json["interest"],
    profileCreatedFor: json["profile_created_for"],
    fullName: json["full_name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    alternateNumber: json["alternate_number"],
    whatsappNumber: json["whatsapp_number"],
    birthDateTime: json["birth_date_time"] == null ? null : (json["birth_date_time"]),
    password: json["password"],
    height: json["height"],
    weight: json["weight"],
    gender: json["gender"],
    bloodGroup: json["blood_group"],
    healthInfo: json["health_info"],
    birthPlace: json["birth_place"],
    member_type: json["member_type"],
    religion: json["religion"],
    motherTongue: json["mother_tongue"],
    cast: json["cast"],
    subCast: json["sub_cast"],
    gotra: json["gotra"],
    manglik: json["manglik"],
    maritalStatus: json["marital_status"],
    noOfChild: json["no_of_child"],
    aboutMyEducation: json["about_my_education"],
    education: json["education"],
    anyOtherQualifications: json["any_other_qualifications"],
    aboutMyCareer: json["about_my_career"],
    employedIn: json["employed_in"],
    occupation: json["occupation"],
    designation: json["designation"],
    organizationName: json["organization_name"],
    jobLocation: json["job_location"],
    annualIncome: json["annual_income"],
    countryLivingIn: json["country_living_in"],
    stateLivingIn: json["state_living_in"],
    cityLivingIn: json["city_living_in"],
    addressLivingIn: json["address_living_in"],
    familyType: json["family_type"],
    familyStatus: json["family_status"],
    fatherName: json["father_name"],
    fatherOccupation: json["father_occupation"],
    motherName: json["mother_name"],
    motherOccupation: json["mother_occupation"],
    noOfBrothers: json["no_of_brothers"],
    noOfSisters: json["no_of_sisters"],
    marriedBrothers: json["married_brothers"],
    marriedSisters: json["married_sisters"],
    familyIncome: json["family_income"],
    aboutFamily: json["about_family"],
    diet: json["diet"],
    isDrinking: json["is_drinking"],
    isSmoking: json["is_smoking"],
    aboutMe: json["about_me"],
    anyDisability: json["any_disability"],
    lookingFor: json["looking_for"],
    partnerAgeFrom: json["partner_age_from"],
    partnerAgeTo: json["partner_age_to"],
    partnerCountry: json["partner_country"],
    partnerReligion: json["partner_religion"],
    partnerCast: json["partner_cast"],
    partnerHeightFrom: json["partner_height_from"],
    partnerHeightTo: json["partner_height_to"],
    partnerEducation: json["partner_education"],
    partnerMothertongue: json["partner_mothertongue"],
    partnerAnnualIncome: json["partner_annual_income"]??"",
    //horoscopeNeeded: json["horoscope_needed"],
    referralCode: json["referral_code"] ?? "",
    idProof: json["id_proof"],
    photo: json["photo"],
    photoPassword: json["photo_password"],
    photoApproved: json["photo_approved"],
    active: json["active"],
    planId: json["plan_id"],
    planActivationDate: json["plan_activation_date"] == null ? null : DateTime.parse(json["plan_activation_date"]),
    profileCompleted: json["profile_completed"],
    promoted: json["promoted"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "registration_date": registrationDate == null ? null : registrationDate!.toIso8601String(),
    "profile_id": profileId,
    "username": username,
    "profile_created_for": profileCreatedFor,
    "full_name": fullName,
    "email": email,
    "mobile_number": mobileNumber,
    "interest": interest,
    "alternate_number": alternateNumber,
    "whatsapp_number": whatsappNumber,
    "birth_date_time": birthDateTime == null ? null : birthDateTime!,
    "password": password,
    "height": height,
    "weight": weight,
    "gender": gender,
    "member_type": member_type,
    "blood_group": bloodGroup,
    "health_info": healthInfo,
    "birth_place": birthPlace,
    "religion": religion,
    "mother_tongue": motherTongue,
    "cast": cast,
    "sub_cast": subCast,
    "gotra": gotra,
    "manglik": manglik,
    "marital_status": maritalStatus,
    "no_of_child": noOfChild,
    "about_my_education": aboutMyEducation,
    "education": education,
    "any_other_qualifications": anyOtherQualifications,
    "about_my_career": aboutMyCareer,
    "employed_in": employedIn,
    "occupation": occupation,
    "designation": designation,
    "organization_name": organizationName,
    "job_location": jobLocation,
    "annual_income": annualIncome,
    "country_living_in": countryLivingIn,
    "state_living_in": stateLivingIn,
    "city_living_in": cityLivingIn,
    "address_living_in": addressLivingIn,
    "family_type": familyType,
    "family_status": familyStatus,
    "father_name": fatherName,
    "father_occupation": fatherOccupation,
    "mother_name": motherName,
    "mother_occupation": motherOccupation,
    "no_of_brothers": noOfBrothers,
    "no_of_sisters": noOfSisters,
    "married_brothers": marriedBrothers,
    "married_sisters": marriedSisters,
    "family_income": familyIncome,
    "about_family": aboutFamily,
    "diet": diet,
    "is_drinking": isDrinking,
    "is_smoking": isSmoking,
    "about_me": aboutMe,
    "any_disability": anyDisability,
    "looking_for": lookingFor,
    "partner_age_from": partnerAgeFrom,
    "partner_age_to": partnerAgeTo,
    "partner_country": partnerCountry,
    "partner_religion": partnerReligion,
    "partner_cast": partnerCast,
    "partner_height_from": partnerHeightFrom,
    "partner_height_to": partnerHeightTo,
    "partner_education": partnerEducation,
    "partner_mothertongue": partnerMothertongue,
    "partner_annual_income": partnerAnnualIncome,
    // "horoscope_needed": horoscopeNeeded==null?"":horoscopeNeeded,
    "referral_code": referralCode,
    "id_proof": idProof,
    "photo": photo,
    "photo_password": photoPassword,
    "photo_approved": photoApproved,
    "active": active,
    "plan_id": planId,
    "plan_activation_date": planActivationDate == null ? null : "${planActivationDate!.year.toString().padLeft(4, '0')}-${planActivationDate!.month.toString().padLeft(2, '0')}-${planActivationDate!.day.toString().padLeft(2, '0')}",
    "profile_completed": profileCompleted,
    "promoted": promoted,
    "remarks": remarks,
  };
}

