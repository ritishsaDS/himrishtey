class StatesModel {
  bool? success;
  List<States>? states;

  StatesModel({this.success, this.states});

  StatesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['States'] != null) {
      states = <States>[];
      json['States'].forEach((v) {
        states!.add(new States.fromJson(v));
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

class States {
  String? id;
  String? name;
  String? countryId;

  States({this.id, this.name, this.countryId});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}
