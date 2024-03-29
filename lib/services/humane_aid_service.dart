import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_1/models/humane_aid_create_response_model.dart';
import 'package:flutter_application_1/models/humane_aid_model.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:http/http.dart' as http;

class HumaneAidService {
  static Future<List<HumanData>?> getHumanData() async {
    try {
      var response = await http.get(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/HumaneAid",
      ));
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        HumaneAidModel humanModel = HumaneAidModel.fromJson(responseBody);
        return humanModel.humanData;
      } else {
        return null;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }

  static Future<List<HumanData>?> getHumanDataByUserId() async {
    try {
      var user = await IdentityServerService.getAuthUser();
      if (user == null) {
        return null;
      }
      var id = user.id;
      var response = await http.get(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/HumaneAid/GetAllByUserId/$id",
      ));
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        HumaneAidModel humanModel = HumaneAidModel.fromJson(responseBody);
        return humanModel.humanData;
      } else {
        return null;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }

  static Future<Data?> getByIdHumanData(String id) async {
    try {
      var response = await http.get(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/HumaneAid/$id",
      ));
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        HumaneAidSingleModel humanModel =
            HumaneAidSingleModel.fromJson(responseBody);
        return humanModel.data;
      } else {
        return null;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }

  static Future<Data?> postHumanData(String body) async {
    try {
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5011,
            scheme: 'https',
            path: "/api/HumaneAid",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        HumaneAidSingleModel humanModel =
            HumaneAidSingleModel.fromJson(responseBody);
        return humanModel.data;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
    }
    return null;
  }

  static Future<bool?> updateHumanData(String body) async {
    try {
      var response = await http.put(
          Uri(
            host: '10.0.2.2',
            port: 5011,
            scheme: 'https',
            path: "/api/HumaneAid",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == HttpStatus.noContent) {
        return true;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
    }
    return false;
  }

  static Future<bool?> deleteHumanData(String id) async {
    try {
      var response = await http.delete(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/HumaneAid/$id",
      ));
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
