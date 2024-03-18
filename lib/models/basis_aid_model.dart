class BasisAidModel {
  List<BasisAidData>? basisAidData;
  String? errors;

  BasisAidModel({this.basisAidData, this.errors});

  BasisAidModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      basisAidData = <BasisAidData>[];
      json['data'].forEach((v) {
        basisAidData!.add(BasisAidData.fromJson(v));
      });
    }
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (basisAidData != null) {
      data['data'] = basisAidData!.map((v) => v.toJson()).toList();
    }
    data['errors'] = errors;
    return data;
  }
}

class BasisAidData {
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

  BasisAidData(
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

  BasisAidData.fromJson(Map<String, dynamic> json) {
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
