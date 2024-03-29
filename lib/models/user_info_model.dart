class UserInfo {
  String? id;
  String? userName;
  String? email;
  String? city;
  String? phoneNumber;
  String? name;

  UserInfo(
      {this.id,
      this.userName,
      this.email,
      this.city,
      this.phoneNumber,
      this.name});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    city = json['city'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['city'] = city;
    data['phoneNumber'] = phoneNumber;
    data['name'] = name;

    return data;
  }
}
