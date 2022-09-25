class HeightModel {
  bool? success;
  List<Heights>? heights;

  HeightModel({this.success, this.heights});

  HeightModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Heights'] != null) {
      heights = <Heights>[];
      json['Heights'].forEach((v) {
        heights!.add(new Heights.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.heights != null) {
      data['Heights'] = this.heights!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heights {
  String? id;
  var height;
  var heightValue;

  Heights({this.id, this.height, this.heightValue});

  Heights.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
    heightValue = json['height_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['height'] = this.height;
    data['height_value'] = this.heightValue;
    return data;
  }
}
