class LoginModel {
  bool? success;
  User? user;

  LoginModel({this.success, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? registrationDate;
  String? profileId;
  String? username;
  String? profileCreatedFor;
  String? fullName;
  String? email;
  String? mobileNumber;
  var alternateNumber;
  var whatsappNumber;
  String? birthDateTime;
  var password;
  String? height;
  String? weight;
  String? gender;
  String? bloodGroup;
  String? healthInfo;
  String? birthPlace;
  String? religion;
  String? motherTongue;
  String? cast;
  String? subCast;
  String? gotra;
  String? manglik;
  String? maritalStatus;
  String? noOfChild;
  String? aboutMyEducation;
  String? education;
  String? anyOtherQualifications;
  String? aboutMyCareer;
  String? employedIn;
  String? occupation;
  String? designation;
  String? organizationName;
  String? jobLocation;
  String? annualIncome;
  String? countryLivingIn;
  String? stateLivingIn;
  String? cityLivingIn;
  String? addressLivingIn;
  String? familyType;
  String? familyStatus;
  String? fatherName;
  String? fatherOccupation;
  String? motherName;
  String? motherOccupation;
  String? noOfBrothers;
  String? noOfSisters;
  String? marriedBrothers;
  String? marriedSisters;
  String? familyIncome;
  String? aboutFamily;
  String? diet;
  String? isDrinking;
  String? isSmoking;
  String? aboutMe;
  String? anyDisability;
  String? lookingFor;
  String? partnerAgeFrom;
  String? partnerAgeTo;
  String? partnerCountry;
  String? partnerReligion;
  String? partnerCast;
  String? partnerHeightFrom;
  String? partnerHeightTo;
  String? partnerEducation;
  String? partnerMothertongue;
  String? partnerAnnualIncome;
  var horoscopeNeeded;
  String? referralCode;
  String? idProof;
  String? photo;
  String? photoPassword;
  String? photoApproved;
  String? active;
  String? activation;
  String? memberType;
  String? planId;
  String? planActivationDate;
  String? profileCompleted;
  String? promoted;
  String? remarks;

  User(
      {this.id,
        this.registrationDate,
        this.profileId,
        this.username,
        this.profileCreatedFor,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.alternateNumber,
        this.whatsappNumber,
        this.birthDateTime,
        this.password,
        this.height,
        this.weight,
        this.gender,
        this.bloodGroup,
        this.healthInfo,
        this.birthPlace,
        this.religion,
        this.motherTongue,
        this.cast,
        this.subCast,
        this.gotra,
        this.manglik,
        this.maritalStatus,
        this.noOfChild,
        this.aboutMyEducation,
        this.education,
        this.anyOtherQualifications,
        this.aboutMyCareer,
        this.employedIn,
        this.occupation,
        this.designation,
        this.organizationName,
        this.jobLocation,
        this.annualIncome,
        this.countryLivingIn,
        this.stateLivingIn,
        this.cityLivingIn,
        this.addressLivingIn,
        this.familyType,
        this.familyStatus,
        this.fatherName,
        this.fatherOccupation,
        this.motherName,
        this.motherOccupation,
        this.noOfBrothers,
        this.noOfSisters,
        this.marriedBrothers,
        this.marriedSisters,
        this.familyIncome,
        this.aboutFamily,
        this.diet,
        this.isDrinking,
        this.isSmoking,
        this.aboutMe,
        this.anyDisability,
        this.lookingFor,
        this.partnerAgeFrom,
        this.partnerAgeTo,
        this.partnerCountry,
        this.partnerReligion,
        this.partnerCast,
        this.partnerHeightFrom,
        this.partnerHeightTo,
        this.partnerEducation,
        this.partnerMothertongue,
        this.partnerAnnualIncome,
        this.horoscopeNeeded,
        this.referralCode,
        this.idProof,
        this.photo,
        this.photoPassword,
        this.photoApproved,
        this.active,
        this.activation,
        this.memberType,
        this.planId,
        this.planActivationDate,
        this.profileCompleted,
        this.promoted,
        this.remarks});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registrationDate = json['registration_date'];
    profileId = json['profile_id'];
    username = json['username'];
    profileCreatedFor = json['profile_created_for'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    alternateNumber = json['alternate_number'];
    whatsappNumber = json['whatsapp_number'];
    birthDateTime = json['birth_date_time'];
    password = json['password'];
    height = json['height'];
    weight = json['weight'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    healthInfo = json['health_info'];
    birthPlace = json['birth_place'];
    religion = json['religion'];
    motherTongue = json['mother_tongue'];
    cast = json['cast'];
    subCast = json['sub_cast'];
    gotra = json['gotra'];
    manglik = json['manglik'];
    maritalStatus = json['marital_status'];
    noOfChild = json['no_of_child'];
    aboutMyEducation = json['about_my_education'];
    education = json['education'];
    anyOtherQualifications = json['any_other_qualifications'];
    aboutMyCareer = json['about_my_career'];
    employedIn = json['employed_in'];
    occupation = json['occupation'];
    designation = json['designation'];
    organizationName = json['organization_name'];
    jobLocation = json['job_location'];
    annualIncome = json['annual_income'];
    countryLivingIn = json['country_living_in'];
    stateLivingIn = json['state_living_in'];
    cityLivingIn = json['city_living_in'];
    addressLivingIn = json['address_living_in'];
    familyType = json['family_type'];
    familyStatus = json['family_status'];
    fatherName = json['father_name'];
    fatherOccupation = json['father_occupation'];
    motherName = json['mother_name'];
    motherOccupation = json['mother_occupation'];
    noOfBrothers = json['no_of_brothers'];
    noOfSisters = json['no_of_sisters'];
    marriedBrothers = json['married_brothers'];
    marriedSisters = json['married_sisters'];
    familyIncome = json['family_income'];
    aboutFamily = json['about_family'];
    diet = json['diet'];
    isDrinking = json['is_drinking'];
    isSmoking = json['is_smoking'];
    aboutMe = json['about_me'];
    anyDisability = json['any_disability'];
    lookingFor = json['looking_for'];
    partnerAgeFrom = json['partner_age_from'];
    partnerAgeTo = json['partner_age_to'];
    partnerCountry = json['partner_country'];
    partnerReligion = json['partner_religion'];
    partnerCast = json['partner_cast'];
    partnerHeightFrom = json['partner_height_from'];
    partnerHeightTo = json['partner_height_to'];
    partnerEducation = json['partner_education'];
    partnerMothertongue = json['partner_mothertongue'];
    partnerAnnualIncome = json['partner_annual_income'];
    horoscopeNeeded = json['horoscope_needed'];
    referralCode = json['referral_code'];
    idProof = json['id_proof'];
    photo = json['photo'];
    photoPassword = json['photo_password'];
    photoApproved = json['photo_approved'];
    active = json['active'];
    activation = json['activation'];
    memberType = json['member_type'];
    planId = json['plan_id'];
    planActivationDate = json['plan_activation_date'];
    profileCompleted = json['profile_completed'];
    promoted = json['promoted'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['registration_date'] = registrationDate;
    data['profile_id'] = profileId;
    data['username'] = username;
    data['profile_created_for'] = profileCreatedFor;
    data['full_name'] = fullName;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['alternate_number'] = alternateNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['birth_date_time'] = birthDateTime;
    data['password'] = password;
    data['height'] = height;
    data['weight'] = weight;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['health_info'] = healthInfo;
    data['birth_place'] = birthPlace;
    data['religion'] = religion;
    data['mother_tongue'] = motherTongue;
    data['cast'] = cast;
    data['sub_cast'] = subCast;
    data['gotra'] = gotra;
    data['manglik'] = manglik;
    data['marital_status'] = maritalStatus;
    data['no_of_child'] = noOfChild;
    data['about_my_education'] = aboutMyEducation;
    data['education'] = education;
    data['any_other_qualifications'] = anyOtherQualifications;
    data['about_my_career'] = aboutMyCareer;
    data['employed_in'] = employedIn;
    data['occupation'] = occupation;
    data['designation'] = designation;
    data['organization_name'] = organizationName;
    data['job_location'] = jobLocation;
    data['annual_income'] = annualIncome;
    data['country_living_in'] = countryLivingIn;
    data['state_living_in'] = stateLivingIn;
    data['city_living_in'] = cityLivingIn;
    data['address_living_in'] = addressLivingIn;
    data['family_type'] = familyType;
    data['family_status'] = familyStatus;
    data['father_name'] = fatherName;
    data['father_occupation'] = fatherOccupation;
    data['mother_name'] = motherName;
    data['mother_occupation'] = motherOccupation;
    data['no_of_brothers'] = noOfBrothers;
    data['no_of_sisters'] = noOfSisters;
    data['married_brothers'] = marriedBrothers;
    data['married_sisters'] = marriedSisters;
    data['family_income'] = familyIncome;
    data['about_family'] = aboutFamily;
    data['diet'] = diet;
    data['is_drinking'] = isDrinking;
    data['is_smoking'] = isSmoking;
    data['about_me'] = aboutMe;
    data['any_disability'] = anyDisability;
    data['looking_for'] = lookingFor;
    data['partner_age_from'] = partnerAgeFrom;
    data['partner_age_to'] = partnerAgeTo;
    data['partner_country'] = partnerCountry;
    data['partner_religion'] = partnerReligion;
    data['partner_cast'] = partnerCast;
    data['partner_height_from'] = partnerHeightFrom;
    data['partner_height_to'] = partnerHeightTo;
    data['partner_education'] = partnerEducation;
    data['partner_mothertongue'] = partnerMothertongue;
    data['partner_annual_income'] = partnerAnnualIncome;
    data['horoscope_needed'] = horoscopeNeeded;
    data['referral_code'] = referralCode;
    data['id_proof'] = idProof;
    data['photo'] = photo;
    data['photo_password'] = photoPassword;
    data['photo_approved'] = photoApproved;
    data['active'] = active;
    data['activation'] = activation;
    data['member_type'] = memberType;
    data['plan_id'] = planId;
    data['plan_activation_date'] = planActivationDate;
    data['profile_completed'] = profileCompleted;
    data['promoted'] = promoted;
    data['remarks'] = remarks;
    return data;
  }
}
