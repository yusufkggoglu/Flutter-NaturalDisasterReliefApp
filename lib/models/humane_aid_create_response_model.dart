class HumaneAidSingleModel {
  Data? data;
  String? errors;

  HumaneAidSingleModel({this.data, this.errors});

  HumaneAidSingleModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = errors;
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
