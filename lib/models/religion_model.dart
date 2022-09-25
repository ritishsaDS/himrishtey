class ReligionModel {
  bool? success;
  List<Religions>? religions;

  ReligionModel({this.success, this.religions});

  ReligionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Religions'] != null) {
      religions = <Religions>[];
      json['Religions'].forEach((v) {
        religions!.add(new Religions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.religions != null) {
      data['Religions'] = this.religions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Religions {
  String? id;
  String? religion;

  Religions({this.id, this.religion});

  Religions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['religion'] = this.religion;
    return data;
  }
}
