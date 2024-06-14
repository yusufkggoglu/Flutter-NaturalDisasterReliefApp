// import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/location_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<String> getLocationLink() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String link =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    return link;
  }

  static Future<LocationModel?> getLocationInfoFromLink(String link) async {
    Uri uri = Uri.parse(link);
    String? query = uri.queryParameters['query'];
    if (query == null) {
      return Future.error('Invalid link format');
    }

    List<String> coords = query.split(',');
    double latitude = double.parse(coords[0]);
    double longitude = double.parse(coords[1]);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[1];

      LocationModel location = LocationModel(
          administrativeArea: place.administrativeArea.toString(),
          subAdministrativeArea: place.subAdministrativeArea.toString(),
          subthrougthfare: place.subThoroughfare.toString(),
          sublocality: place.subLocality.toString());
      return location;
    } else {
      return null;
    }
  }

  static Future<LocationModel?> getLocationInfoCoordinate(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[1];

      LocationModel location = LocationModel(
          administrativeArea: place.administrativeArea.toString(),
          subAdministrativeArea: place.subAdministrativeArea.toString(),
          subthrougthfare: place.subThoroughfare.toString(),
          sublocality: place.subLocality.toString());
      return location;
    } else {
      return null;
    }
  }

  static double extractLatitude(String url) {
    RegExp regex = RegExp(r'@(-?\d+\.\d+),');
    Match? match = regex.firstMatch(url);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 0.0;
  }

  static double extractLongitude(String url) {
    RegExp regex = RegExp(r',(-?\d+\.\d+),');
    Match? match = regex.firstMatch(url);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 0.0;
  }

  // static Future<String> getLongUrl(String shortUrl) async {
  //   try {
  //     var currentUrl = shortUrl;
  //     var redirectCount = 0;
  //     final maxRedirects = 5;

  //     while (redirectCount < maxRedirects) {
  //       final response = await http
  //           .get(Uri.parse(currentUrl), headers: {'User-Agent': 'Mozilla/5.0'});

  //       if (response.statusCode >= 300 && response.statusCode < 400) {
  //         final location = response.headers['location'];
  //         if (location != null) {
  //           currentUrl = location.startsWith('http')
  //               ? location
  //               : Uri.parse(currentUrl).resolve(location).toString();
  //           redirectCount++;
  //         } else {
  //           break;
  //         }
  //       } else {
  //         break;
  //       }
  //     }

  //     return currentUrl;
  //   } catch (e) {
  //     print('Error: $e');
  //     return "null";
  //   }
  // }

  // static Future<String> getMapsLink() async {
  //   final Uri uri = Uri.https(
  //     'maps.googleapis.com',
  //     '/maps/api/geocode/json',
  //     {
  //       'address': "",
  //       'key': "",
  //     },
  //   );

  //   final http.Response response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);

  //     if (data['status'] == 'OK') {
  //       final double lat = data['results'][0]['geometry']['location']['lat'];
  //       final double lng = data['results'][0]['geometry']['location']['lng'];
  //       return 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  //     } else {
  //       throw Exception('Geocoding API error: ${data['status']}');
  //     }
  //   } else {
  //     throw Exception('Failed to load geocoding data');
  //   }
  // }
}
