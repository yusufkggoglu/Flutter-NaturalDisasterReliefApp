// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/humane_aid_update.dart';
import 'package:flutter_application_1/models/humane_aid_create_response_model.dart';
import 'package:flutter_application_1/services/humane_aid_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class HumaneAidDetailByUser extends StatefulWidget {
  final String id;
  const HumaneAidDetailByUser({super.key, required this.id});
  @override
  State<HumaneAidDetailByUser> createState() => _HumaneAidDetailByUser();
}

class _HumaneAidDetailByUser extends State<HumaneAidDetailByUser> {
  @override
  void initState() {
    super.initState();
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
                            "İnsani Yardım Talebim",
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
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        showAlertDialog(context);
                      },
                      child: SizedBox(
                        width: deviceWidth,
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "SİL",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HumaneAidUpdate(
                                  id: widget.id,
                                )));
                      },
                      child: SizedBox(
                        width: deviceWidth,
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "GÜNCELLE",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
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
                    child: FutureBuilder<Data?>(
                        future: HumaneAidService.getByIdHumanData(widget.id),
                        builder: (context, snapshot) {
                          var humanData = snapshot.data;
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Ad Soyad',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData!.name.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Telefon',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.phone.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'İl',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.province.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'İlçe',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.district.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Mahalle',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.neighborhood.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Adres',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.address.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Konum Url',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: InkWell(
                                    onTap: () {
                                      // ignore: deprecated_member_use
                                      launch(humanData.locationUrl
                                          .toString()); // basisAidData.locationUrl burada tıklanabilir URL'yi içermelidir
                                    },
                                    child: Text(
                                      humanData.locationUrl.toString(),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors
                                            .blue, // Linkin mavi renkte olmasını sağlar
                                        decoration: TextDecoration
                                            .underline, // Linkin altını çizer
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'İstenilen Yardım Açıklaması',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.description.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Yardım Talebi Oluşturulma Tarihi',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    humanData.createdTime.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Hayır"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Evet"),
      onPressed: () async {
        var data = await HumaneAidService.deleteHumanData(widget.id);
        if (data != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.green,
                content: Text('Yardım talebiniz silindi.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                content: Text('Hata oluştu ! Lütfen tekrar deneyiniz.')),
          );
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Emin misin ? "),
      content: const Text("Yardım talebini silmek istediğinize emin misiniz ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
