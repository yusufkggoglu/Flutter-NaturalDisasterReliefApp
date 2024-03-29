class HumaneAidModel {
  List<HumanData>? humanData;
  String? errors;

  HumaneAidModel({this.humanData, this.errors});

  HumaneAidModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      humanData = <HumanData>[];
      json['data'].forEach((v) {
        humanData!.add(HumanData.fromJson(v));
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

class HumanData {
  String? id;
  String? userId;
  String? name;
  String? phone;
  String? province;
  String? district;
  String? neighborhood;
  String? address;
  String? locationUrl;
  String? subTitle;
  String? description;
  bool? status;
  String? createdTime;

  HumanData(
      {this.id,
      this.userId,
      this.name,
      this.phone,
      this.province,
      this.district,
      this.neighborhood,
      this.address,
      this.locationUrl,
      this.subTitle,
      this.description,
      this.status,
      this.createdTime});

  HumanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    province = json['province'];
    district = json['district'];
    neighborhood = json['neighborhood'];
    address = json['address'];
    locationUrl = json['locationUrl'];
    subTitle = json['subTitle'];
    description = json['description'];
    status = json['status'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['province'] = province;
    data['district'] = district;
    data['neighborhood'] = neighborhood;
    data['address'] = address;
    data['locationUrl'] = locationUrl;
    data['subTitle'] = subTitle;
    data['description'] = description;
    data['status'] = status;
    data['createdTime'] = createdTime;
    return data;
  }
}
