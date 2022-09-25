class familyStatus {
  bool? success;
  List<MotherTongues>? motherTongues;

  familyStatus({this.success, this.motherTongues});

  familyStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Mother Tongues'] != null) {
      motherTongues = <MotherTongues>[];
      json['Mother Tongues'].forEach((v) {
        motherTongues!.add(new MotherTongues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.motherTongues != null) {
      data['Mother Tongues'] =
          this.motherTongues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MotherTongues {
  String? id;
  String? value;

  MotherTongues({this.id, this.value});

  MotherTongues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
