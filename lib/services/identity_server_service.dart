// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_1/constants/identity.dart';
import 'package:flutter_application_1/models/error_response_model.dart';
import 'package:flutter_application_1/models/login_response_model.dart';
import 'package:flutter_application_1/models/user_info_model.dart';
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
        var user = await IdentityServerService.getAuthUser();
        await addSecureData("USER_ID", user!.id.toString());
        //diğer user bilgilerini de ekleyebilirsin
        return loginResponse;
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}');
    }
    return null;
  }

  static Future<String> register(String body) async {
    try {
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/signup",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == HttpStatus.noContent) {
        return "success";
      }
      if (response.statusCode == HttpStatus.badRequest) {
        var responseBody = jsonDecode(response.body);
        ErrorResponse errorResponse = ErrorResponse.fromJson(responseBody);
        var message = errorResponse.errors.toString();
        message = message.replaceAll('[', ' ').replaceAll(']', ' ');
        return message;
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}');
      return "Yolunma gitmeyen bir şeyler var. Tekrar deneyiniz !";
    }
    return "Yolunma gitmeyen bir şeyler var. Tekrar deneyiniz !";
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

  static Future<UserInfo?> getAuthUser() async {
    try {
      var token = await readSecureData(SECURE_NOTE_KEY);
      if (token == null) {
        return null;
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
        var responseBody = jsonDecode(response.body);
        UserInfo userInfo = UserInfo.fromJson(responseBody);
        return userInfo;
      }
    } catch (e) {
      log('Getting data error: ${e.toString()}');
      return null;
    }
  }

  static Future<bool?> updateUserInfo(String body) async {
    try {
      var token = await readSecureData(SECURE_NOTE_KEY);
      if (token == null) {
        return null;
      }
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/updateinfo",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (e) {
      log('Getting data error: ${e.toString()}');
      return false;
    }
    return false;
  }

  static Future<bool?> changePassword(String body) async {
    try {
      var token = await readSecureData(SECURE_NOTE_KEY);
      if (token == null) {
        return null;
      }
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/updatepassword",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (e) {
      log('Getting data error: ${e.toString()}');
      return false;
    }
    return false;
  }
}
