class CityModel {
  bool? success;
  List<Statess>? states;

  CityModel({this.success, this.states});

  CityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['States'] != null) {
      states = <Statess>[];
      json['States'].forEach((v) {
        states!.add(new Statess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.states != null) {
      data['States'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statess {
  String? id;
  String? name;
  String? stateId;

  Statess({this.id, this.name, this.stateId});

  Statess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    return data;
  }
}
