import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class HumaneAidDetail extends StatefulWidget {
  const HumaneAidDetail({super.key});

  @override
  State<HumaneAidDetail> createState() => _HumaneAidDetailState();
}

class _HumaneAidDetailState extends State<HumaneAidDetail> {
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
                            "İnsani Yardım Talebi",
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
                    child: const Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Ad Soyad',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            'Yusuf Küçükgökgözoğlu',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Telefon',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            '05386938784',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Adres',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            'Abdi ipekçi mah. 1547 sok. Kocaeli/Darıca',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Ad Soyad',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            'Yusuf Küçükgökgözoğlu',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Yardım Tipi',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            'İnsani Yardım',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'İstenen Yardım Açıklaması',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            'Battaniye ve yorgan ihtiyacımız var.',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Oluşturulma Tarihi',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            '28.02.2024 - 11.00',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
