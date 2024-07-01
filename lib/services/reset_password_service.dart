import 'dart:math';

import 'package:http/http.dart' as http;

class ResetPasswordService {
  static Future<String?> verifyEmail(String body) async {
    try {
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/VerifyEmailAndSend",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        return "OK";
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}' as num);
    }
    return null;
  }

  static Future<String?> verifyCode(String body) async {
    try {
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/VerifyCode",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return "OK";
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}' as num);
    }
    return null;
  }

  static Future<String?> resetPassword(String body) async {
    try {
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5001,
            scheme: 'https',
            path: "/api/user/ResetPassword",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return "OK";
      }
    } catch (e) {
      log('Authenticate error: ${e.toString()}' as num);
    }
    return null;
  }
}
