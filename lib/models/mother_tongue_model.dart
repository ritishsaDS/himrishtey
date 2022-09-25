class MotherTongueModel {
  bool? success;
  List<MotherTongues>? motherTongues;

  MotherTongueModel({this.success, this.motherTongues});

  MotherTongueModel.fromJson(Map<String, dynamic> json) {
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
  String? motherTongue;

  MotherTongues({this.id, this.motherTongue});

  MotherTongues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    motherTongue = json['mother_tongue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mother_tongue'] = this.motherTongue;
    return data;
  }
}
