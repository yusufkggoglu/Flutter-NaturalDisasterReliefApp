import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

import 'services/humane_aid_service.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  // IdentityServerService.deleteSecureData(SECURE_NOTE_KEY);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
