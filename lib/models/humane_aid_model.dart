class HumaneAidModel {
  List<HumaneData>? humanData;
  String? errors;

  HumaneAidModel({this.humanData, this.errors});

  HumaneAidModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      humanData = <HumaneData>[];
      json['data'].forEach((v) {
        humanData!.add(HumaneData.fromJson(v));
      });
    }
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (humanData != null) {
      data['data'] = humanData!.map((v) => v.toJson()).toList();
    }
    data['errors'] = errors;
    return data;
  }
}

class HumaneData {
  String? id;
  String? userId;
  String? name;
  String? phone;
  String? location;
  String? locationUrl;
  String? helpType;
  String? description;
  String? picture;
  bool? status;
  String? createdTime;

  HumaneData(
      {this.id,
      this.userId,
      this.name,
      this.phone,
      this.location,
      this.locationUrl,
      this.helpType,
      this.description,
      this.picture,
      this.status,
      this.createdTime});

  HumaneData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    location = json['location'];
    locationUrl = json['locationUrl'];
    helpType = json['helpType'];
    description = json['description'];
    picture = json['picture'];
    status = json['status'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['location'] = location;
    data['locationUrl'] = locationUrl;
    data['helpType'] = helpType;
    data['description'] = description;
    data['picture'] = picture;
    data['status'] = status;
    data['createdTime'] = createdTime;
    return data;
  }
}
