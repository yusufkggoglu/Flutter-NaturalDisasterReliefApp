// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/humane_aid_service.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:flutter_application_1/services/location_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class HumaneAidAdd extends StatefulWidget {
  const HumaneAidAdd({super.key});

  @override
  State<HumaneAidAdd> createState() => _HumaneAidAddState();
}

class _HumaneAidAddState extends State<HumaneAidAdd> {
  final _key = GlobalKey<FormState>();
  String currentLink = '';
  bool _isLoading = false;

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
  }

  Future<void> getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      currentLink = await LocationService.getLocationLink();
      var addressInfo =
          await LocationService.getLocationInfoFromLink(currentLink);
      _locationUrlController.text = currentLink.toString();
      _districtController.text = addressInfo!.subAdministrativeArea.toString();
      _provinceController.text = addressInfo.administrativeArea.toString();
      _neighborhoodController.text = "${addressInfo.sublocality} mahallesi";

      if (!addressInfo.subthrougthfare!.toLowerCase().contains("no")) {
        _addressController.text = "No ${addressInfo.subthrougthfare}";
      } else {
        _addressController.text = addressInfo.subthrougthfare.toString();
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> fillInfoByUrl() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     var url = _locationUrlController.text;
  //     if (url.contains("maps.app.goo.gl")) {
  //       url = await LocationService.getLongUrl(url);
  //     }

  //     var latitude = LocationService.extractLatitude(url);
  //     var longitude = LocationService.extractLongitude(url);
  //     var addressInfo =
  //         await LocationService.getLocationInfoCoordinate(latitude, longitude);
  //     _locationUrlController.text = currentLink.toString();
  //     _districtController.text = addressInfo!.subAdministrativeArea.toString();
  //     _provinceController.text = addressInfo.administrativeArea.toString();
  //     _neighborhoodController.text = "${addressInfo.sublocality} mahallesi";
  //     if (!addressInfo.subthrougthfare!.toLowerCase().contains("no")) {
  //       _addressController.text = "No ${addressInfo.subthrougthfare}";
  //     } else {
  //       _addressController.text = addressInfo.subthrougthfare.toString();
  //     }
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

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
                            child: TextFormField(
                              controller: _provinceController,
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
                                labelText: 'İl',
                              ),
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
                          // Padding(
                          //     padding: const EdgeInsets.all(20),
                          //     child: SizedBox(
                          //       width: deviceWidth,
                          //       height: 50.0,
                          //       child: ElevatedButton(
                          //         onPressed: () async {
                          //           await fillInfoByUrl();
                          //         },
                          //         child: _isLoading
                          //             ? const CircularProgressIndicator(
                          //                 color: Colors.white,
                          //               )
                          //             : const Text('Girilen Konum URL'
                          //                 'ine göre bilgileri getir'),
                          //       ),
                          //     )),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: deviceWidth,
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await getCurrentLocation();
                                  },
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          'Anlık Konum Bilgilerimi Getir'),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: deviceWidth,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    var province = _provinceController.text;
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
                                    var phone = identity.phoneNumber.toString();
                                    var userId = identity.id.toString();
                                    var body = {
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

                                    var data =
                                        await HumaneAidService.postHumanData(
                                            jsonEncode(body));
                                    log('DATA: $data');
                                    if (data != null) {
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
