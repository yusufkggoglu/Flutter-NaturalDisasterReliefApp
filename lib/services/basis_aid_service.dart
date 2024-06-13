import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_1/constants/identity.dart';
import 'package:flutter_application_1/models/basis_aid_create_response_model.dart';
import 'package:flutter_application_1/models/basis_aid_model.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:http/http.dart' as http;

class BasisAidService {
  static Future<List<BasisAidData>?> getBasisAidData() async {
    try {
      var token = await IdentityServerService.readSecureData(SECURE_NOTE_KEY);
      if (token == null) {
        return null;
      }
      token = 'Bearer $token';
      var response = await http.get(
          Uri(
            host: '10.0.2.2',
            port: 5011,
            scheme: 'https',
            path: "/api/BasisAid",
          ),
          headers: {
            'Authorization': token,
          });
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        BasisAidModel basisAidModel = BasisAidModel.fromJson(responseBody);
        return basisAidModel.basisAidData;
      } else {
        return null;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }

  static Future<BasisAidSingleData?> getByIdBasisAidData(String id) async {
    try {
      var response = await http.get(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/BasisAid/$id",
      ));
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        BasisAidSingleModel basisAidModel =
            BasisAidSingleModel.fromJson(responseBody);
        return basisAidModel.data;
      } else {
        return null;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }

  static Future<BasisAidSingleData?> postBasisAidData(String body) async {
    try {
      var response = await http.post(
          Uri(
            host: '10.0.2.2',
            port: 5011,
            scheme: 'https',
            path: "/api/BasisAid",
          ),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        BasisAidSingleModel basisAidModel =
            BasisAidSingleModel.fromJson(responseBody);
        return basisAidModel.data;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
    }
    return null;
  }

  static Future<List<BasisAidData>?> getBasisAidDataByUserId() async {
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
        path: "/api/BasisAid/GetAllByUserId/$id",
      ));
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        BasisAidModel basisAidModel = BasisAidModel.fromJson(responseBody);
        return basisAidModel.basisAidData;
      } else {
        return null;
      }
    } catch (e) {
      log('Getting data from human data error: ${e.toString()}');
      return null;
    }
  }

  static Future<bool?> updateBasisAidData(String body) async {
    try {
      var response = await http.put(
          Uri(
            host: '10.0.2.2',
            port: 5011,
            scheme: 'https',
            path: "/api/BasisAid",
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

  static Future<bool?> deleteBasisAidData(String id) async {
    try {
      var response = await http.delete(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/BasisAid/$id",
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
