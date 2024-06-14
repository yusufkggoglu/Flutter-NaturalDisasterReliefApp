class ErrorResponse {
  Null data;
  List<String>? errors;

  ErrorResponse({this.data, this.errors});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    errors = json['errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['errors'] = errors;
    return data;
  }
}
