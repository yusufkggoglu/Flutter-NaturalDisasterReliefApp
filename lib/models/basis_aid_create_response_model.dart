class BasisAidSingleModel {
  BasisAidSingleData? data;
  String? errors;

  BasisAidSingleModel({this.data, this.errors});

  BasisAidSingleModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? BasisAidSingleData.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    data['errors'] = errors;
    return data;
  }
}

class BasisAidSingleData {
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
  int? amount;
  bool? status;
  String? createdTime;

  BasisAidSingleData(
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
      this.amount,
      this.status,
      this.createdTime});

  BasisAidSingleData.fromJson(Map<String, dynamic> json) {
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
    amount = json['amount'];
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
    data['amount'] = amount;
    data['status'] = status;
    data['createdTime'] = createdTime;
    return data;
  }
}
