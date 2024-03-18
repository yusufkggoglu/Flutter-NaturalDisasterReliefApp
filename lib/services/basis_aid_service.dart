import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_1/models/basis_aid_create_response_model.dart';
import 'package:flutter_application_1/models/basis_aid_model.dart';
import 'package:http/http.dart' as http;

class BasisAidService {
  static Future<List<BasisAidData>?> getBasisAidData() async {
    try {
      var response = await http.get(Uri(
        host: '10.0.2.2',
        port: 5011,
        scheme: 'https',
        path: "/api/BasisAid",
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
}
