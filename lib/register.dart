// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordCheckController;
  late final TextEditingController _emailController;
  late final TextEditingController _cityController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordCheckController = TextEditingController();
    _emailController = TextEditingController();
    _cityController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
                            "Kayıt Ol",
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
                                controller: _usernameController,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (value.length >= 5) {
                                      return null;
                                    } else {
                                      return 'Alan en az 5 harften oluşmalıdır !';
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Kullanıcı Adı',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (value.length >= 8) {
                                      return null;
                                    } else {
                                      return 'Alan en az 8 harften oluşmalıdır !';
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Şifre',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _passwordCheckController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (value != _passwordController.text) {
                                      return 'Şifreler uyuşmuyor !';
                                    }
                                    if (value.length >= 8) {
                                      return null;
                                    } else {
                                      return 'Alan en az 8 harften oluşmalıdır !';
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tekrar Şifre',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _emailController,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (value.length >= 5) {
                                      return null;
                                    } else {
                                      return 'Alan en az 5 harften oluşmalıdır !';
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _cityController,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (value.length >= 3) {
                                      return null;
                                    } else {
                                      return 'Alan en az 3 harften oluşmalıdır !';
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Şehir',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _phoneController,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  } else {
                                    if (value.length == 11) {
                                      return null;
                                    } else {
                                      return 'Alan 11 karakterden oluşmalıdır !';
                                    }
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Telefon Numarası',
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
                                      var username = _usernameController.text;
                                      var passwd = _passwordController.text;
                                      var city = _cityController.text;
                                      var email = _emailController.text;
                                      var phone = _phoneController.text;

                                      var body = {
                                        'UserName': username,
                                        'Email': email,
                                        'Password': passwd,
                                        'City': city,
                                        'PhoneNumber': phone
                                      };

                                      var data =
                                          await IdentityServerService.register(
                                              jsonEncode(body));
                                      if (data == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Kayıt yapıldı , Giriş yapabilirsiniz.')),
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
                                                  'Kayıt yapılamadı, Tekrar deneyiniz.')),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Kayıt Ol',
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
