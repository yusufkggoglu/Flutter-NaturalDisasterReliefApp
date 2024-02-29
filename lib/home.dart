// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/humane_aid_list.dart';
import 'package:flutter_application_1/information.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.afad.gov.tr/');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  width: deviceWidth,
                  height: deviceHeight / 4,
                  decoration: const BoxDecoration(
                      color: Colors.purple,
                      image: DecorationImage(
                          image: AssetImage("lib/assets/images/header.png"),
                          fit: BoxFit.cover)),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text(
                          "Doğal Afet ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Yardımlaşma Platformu",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async => {launchUrl(_url)},
                      child: Card(
                        child: SizedBox(
                          width: deviceWidth,
                          height: deviceHeight / 7,
                          child: const ListTile(
                            title: Text(
                              'AFAD',
                              style: TextStyle(fontSize: 25),
                            ),
                            subtitle:
                                Text('Afet ve Acil Durum Yönetim Başkanlığı'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Information()))
                      },
                      child: Card(
                        child: SizedBox(
                          width: deviceWidth,
                          height: deviceHeight / 7,
                          child: const ListTile(
                            title: Text(
                              'Bilinçlenme ve Önlem',
                              style: TextStyle(fontSize: 25),
                            ),
                            subtitle: Text(
                                'Doğal Afet Anında Yapılması Gerekenler ve Önlemler.'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {print("Temel Yardım")},
                      child: Card(
                        child: SizedBox(
                          width: deviceWidth,
                          height: deviceHeight / 7,
                          child: const ListTile(
                            title: Text(
                              'Temel Yardım',
                              style: TextStyle(fontSize: 25),
                            ),
                            subtitle: Text(
                                'Temel (Gıda, Giyim, Barınma) Yardım Sahipleri'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HumaneAid()))
                      },
                      child: Card(
                        child: SizedBox(
                          width: deviceWidth,
                          height: deviceHeight / 7,
                          child: const ListTile(
                            title: Text(
                              'İnsani Yardım',
                              style: TextStyle(fontSize: 25),
                            ),
                            subtitle: Text(
                                'İnsani (İş Makineleri ve İnsan)Yardım Sahipleri'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
