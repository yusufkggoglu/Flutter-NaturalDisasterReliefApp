class UserInfo {
  String? id;
  String? userName;
  String? email;
  String? city;

  UserInfo({this.id, this.userName, this.email, this.city});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['city'] = city;
    return data;
  }
}
