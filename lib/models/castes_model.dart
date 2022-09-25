class CastesModel {
  bool? success;
  List<Casts>? casts;

  CastesModel({this.success, this.casts});

  CastesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Casts'] != null) {
      casts = <Casts>[];
      json['Casts'].forEach((v) {
        casts!.add(new Casts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.casts != null) {
      data['Casts'] = this.casts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Casts {
  String? id;
  String? cast;

  Casts({this.id, this.cast});

  Casts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cast = json['cast'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cast'] = this.cast;
    return data;
  }
}
