import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_1/constants/identity.dart';
import 'package:flutter_application_1/models/login_response_model.dart';
import 'package:http/http.dart' as http;

class IdentityServerService {
  static Future<String?> readSecureData(String key) async {
    var value = await containsKeyInSecureData(key);
    if (value) {
      var readData = await storage.read(key: key);
      return readData;
    }
    return null;
  }

  static Future<void> deleteSecureData(String key) async {
    var value = await containsKeyInSecureData(key);
    if (value) {
      await storage.delete(key: key);
    }
  }

  static Future addSecureData(key, value) async {
    await storage.write(key: key, value: value);
  }

  static Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await storage.containsKey(key: key);
    return containsKey;
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
        await addSecureData(SECURE_NOTE_KEY, loginResponse.accessToken);
        // String? value = await readSecureData(SECURE_NOTE_KEY);
        // print(value);
        return loginResponse;
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}');
    }
    return null;
  }

  static Future<bool> checkAuth() async {
    try {
      var token = await readSecureData(SECURE_NOTE_KEY);
      if (token == null) {
        return false;
      }
      var response = await http.get(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/getuser",
          ),
          headers: {
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Getting data error: ${e.toString()}');
      return false;
    }
  }
}
