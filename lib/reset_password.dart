// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/reset_password_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  final String code;

  const ResetPassword({super.key, required this.email, required this.code});

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _newPasswordController;
  late final TextEditingController _newPassword2Controller;
  late final counter = 0;
  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _newPassword2Controller = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _newPassword2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  width: deviceWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () => {Navigator.of(context).pop()},
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                      ),
                      const Column(
                        children: <Widget>[
                          Text(
                            "Doğal Afet Yardımlaşma Platformu",
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 14),
                          ),
                          Text(
                            "Şifremi Unuttum",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F2F3E)),
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const UserInterface()))
                              },
                          child: const Icon(
                            Icons.person,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    width: deviceWidth,
                    child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _newPasswordController,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (_newPassword2Controller.text != value) {
                                      return 'Şifreler uyuşmuyor !';
                                    }
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Yeni Şifre',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _newPassword2Controller,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (_newPasswordController.text != value) {
                                      return 'Şifreler uyuşmuyor !';
                                    }
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Yeni Şifre Tekrar',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: deviceWidth,
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      var newPassword =
                                          _newPasswordController.text;
                                      var body = {
                                        'Email': widget.email,
                                        'Password': newPassword,
                                        'Code': widget.code,
                                      };

                                      var data = await ResetPasswordService
                                          .resetPassword(jsonEncode(body));
                                      if (data == "OK") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Şifre başarıyla değiştirildi, Giriş yapabilirsiniz.')),
                                        );
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ),
                                            (route) => false);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  'Bir hata oluştu, Tekrar deneyiniz.')),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Şifremi Değiştir',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
