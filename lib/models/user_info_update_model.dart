class UserInfoUpdate {
  String? userName;
  String? email;
  String? city;
  String? phoneNumber;
  String? name;

  UserInfoUpdate(
      {this.userName, this.email, this.city, this.phoneNumber, this.name});

  UserInfoUpdate.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    city = json['city'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['email'] = email;
    data['city'] = city;
    data['phoneNumber'] = phoneNumber;
    data['name'] = name;

    return data;
  }
}
