import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/humane_aid_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class HumaneAidAdd extends StatefulWidget {
  const HumaneAidAdd({super.key});

  @override
  State<HumaneAidAdd> createState() => _HumaneAidAddState();
}

class _HumaneAidAddState extends State<HumaneAidAdd> {
  final _key = GlobalKey<FormState>();

  late final TextEditingController _adresController;

  @override
  void initState() {
    super.initState();
    _adresController = TextEditingController();
  }

  @override
  void dispose() {
    _adresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // double deviceHeight = MediaQuery.of(context).size.height;
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
                          "İnsani Yardım Talebi +",
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
                                  builder: (context) => const UserInterface()))
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
                              controller: _adresController,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bu alan boş bırakılamaz!';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Adres',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(14),
                            child: TextField(
                              // controller: ,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Adres Google Linki',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(14),
                            child: TextField(
                              // controller: ,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Yardım Talebi İçeriği',
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
                                    var adres = _adresController.text;
                                    var body = {
                                      'location': adres,
                                    };

                                    var data =
                                        await HumaneAidService.postHumanData(
                                            jsonEncode(body));
                                    log('DATAAA: $data');
                                    if (data == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            backgroundColor: Colors.green,
                                            content: Text('Processing Data')),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                          (route) => false);
                                    }
                                  }
                                },
                                child: const Text(
                                  'Kayıt Et',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
