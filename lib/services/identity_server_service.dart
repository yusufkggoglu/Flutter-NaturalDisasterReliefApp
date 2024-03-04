import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/constants/identity.dart';
import 'package:flutter_application_1/models/login_response_model.dart';
import 'package:http/http.dart' as http;

class IdentityServerService {
  static Future readToken() async {
    String? value = await storage.read(key: "token");
    return value;
  }

  static Future<LoginResponseModel?> authenticate(
      Map<String, String> body) async {
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request(
          'POST', Uri.parse('https://10.0.2.2:5001/connect/token'));
      request.headers.clear();
      request.headers.addAll(headers);
      request.bodyFields = body;
      request.encoding = Encoding.getByName('utf-8')!;

      final response = await request.send();
      if (response.statusCode == 200) {
        var responseBody =
            jsonDecode(utf8.decoder.convert(await response.stream.single));
        LoginResponseModel loginResponse =
            LoginResponseModel.fromJson(responseBody);
        await storage.write(key: "token", value: loginResponse.accessToken);
        String? value = await storage.read(key: "token");
        print(value);
        return loginResponse;
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}');
    }
    return null;
  }
}
