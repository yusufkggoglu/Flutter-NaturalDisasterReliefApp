// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/constants/province.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/humane_aid_service.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class HumaneAidUpdate extends StatefulWidget {
  final String id;
  const HumaneAidUpdate({super.key, required this.id});

  @override
  State<HumaneAidUpdate> createState() => _HumaneAidUpdateState();
}

class _HumaneAidUpdateState extends State<HumaneAidUpdate> {
  final _key = GlobalKey<FormState>();
  String? _selectedProvince;

  late final TextEditingController _provinceController;
  late final TextEditingController _districtController;
  late final TextEditingController _neighborhoodController;
  late final TextEditingController _addressController;
  late final TextEditingController _locationUrlController;
  late final TextEditingController _subTitleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _provinceController = TextEditingController();
    _districtController = TextEditingController();
    _neighborhoodController = TextEditingController();
    _addressController = TextEditingController();
    _locationUrlController = TextEditingController();
    _subTitleController = TextEditingController();
    _descriptionController = TextEditingController();
    getById();
  }

  @override
  void dispose() {
    _provinceController.dispose();
    _districtController.dispose();
    _neighborhoodController.dispose();
    _addressController.dispose();
    _locationUrlController.dispose();
    _subTitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> getById() async {
    var data = await HumaneAidService.getByIdHumanData(widget.id);
    _subTitleController.text = data!.subTitle.toString();
    _descriptionController.text = data.description.toString();
    _provinceController.text = data.province.toString();
    _districtController.text = data.district.toString();
    _neighborhoodController.text = data.neighborhood.toString();
    _addressController.text = data.address.toString();
    _locationUrlController.text = data.locationUrl.toString();
    _selectedProvince = data.province.toString();

    setState(() {});
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
                                controller: _subTitleController,
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
                                  labelText: 'Yardım İçeriği (Bir kaç kelime)',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 10,
                                controller: _descriptionController,
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
                                    labelText: 'Yardım Açıklaması',
                                    hintMaxLines: 2),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: DropdownButtonFormField<String>(
                                value: _selectedProvince,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'İl',
                                ),
                                items: provinces.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedProvince = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bu alan boş bırakılamaz!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _districtController,
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
                                  labelText: 'İlçe',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _neighborhoodController,
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
                                  labelText: 'Mahalle',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                controller: _addressController,
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
                                    labelText: 'Adres',
                                    hintMaxLines: 2),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: TextFormField(
                                controller: _locationUrlController,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Konum URL (İsteğe bağlı)',
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
                                      var province = _selectedProvince;
                                      var district = _districtController.text;
                                      var neighborhood =
                                          _neighborhoodController.text;
                                      var address = _addressController.text;
                                      var locationUrl =
                                          _locationUrlController.text;
                                      var subTitle = _subTitleController.text;
                                      var description =
                                          _descriptionController.text;
                                      var identity = await IdentityServerService
                                          .getAuthUser();
                                      var name =
                                          "${identity!.name} ${identity.surname}";
                                      var phone =
                                          identity.phoneNumber.toString();
                                      var userId = identity.id.toString();
                                      var body = {
                                        'id': widget.id,
                                        'province': province,
                                        'district': district,
                                        'neighborhood': neighborhood,
                                        'address': address,
                                        'locationUrl': locationUrl,
                                        'subTitle': subTitle,
                                        'description': description,
                                        "status": true,
                                        "userId": userId,
                                        "name": name,
                                        "phone": phone,
                                      };

                                      var data = await HumaneAidService
                                          .updateHumanData(jsonEncode(body));
                                      log('DATA: $data');
                                      if (data != null && data == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Yardım talebiniz başarıyla gönderildi.')),
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
                                                  'Hata oluştu ! Lütfen tekrar deneyiniz.')),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Güncelle',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        )),
      ),
    );
  }
}
