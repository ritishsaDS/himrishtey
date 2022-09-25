class MaritalStatusModel {
  bool? success;
  List<MaritalStatus>? maritalStatus;

  MaritalStatusModel({this.success, this.maritalStatus});

  MaritalStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Marital Status'] != null) {
      maritalStatus = <MaritalStatus>[];
      json['Marital Status'].forEach((v) {
        maritalStatus!.add(new MaritalStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.maritalStatus != null) {
      data['Marital Status'] =
          this.maritalStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaritalStatus {
  String? id;
  String? maritalStatus;

  MaritalStatus({this.id, this.maritalStatus});

  MaritalStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maritalStatus = json['marital_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marital_status'] = this.maritalStatus;
    return data;
  }
}
