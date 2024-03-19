// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_application_1/basis_aid_detail_by_user.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/humane_aid_detail_by_user.dart';
import 'package:flutter_application_1/models/basis_aid_model.dart';
import 'package:flutter_application_1/services/basis_aid_service.dart';
import 'package:flutter_application_1/services/humane_aid_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

import 'models/humane_aid_model.dart';

class HumaneAidListByUser extends StatefulWidget {
  final String id;

  const HumaneAidListByUser({super.key, required this.id});

  @override
  State<HumaneAidListByUser> createState() => _HumaneAidListByUser();
}

class _HumaneAidListByUser extends State<HumaneAidListByUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: Column(
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
                        "Yardım Taleplerim",
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
            Container(
              child: Card(
                child: const Text("İnsani Yardım Taleplerim",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                color: Colors.red[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(20),
              ),
              width: deviceWidth,
            ),
            Expanded(
              child: FutureBuilder<List<HumanData>?>(
                  future: HumaneAidService.getHumanDataByUserId(),
                  builder: (context, snapshot) {
                    var humanData = snapshot.data;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: humanData?.length,
                        itemBuilder: (context, index) {
                          var human = humanData?[index];
                          return InkWell(
                            onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HumaneAidDetailByUser(
                                        id: human!.id.toString(),
                                      )))
                            },
                            child: Card(
                              child: SizedBox(
                                width: deviceWidth,
                                height: deviceHeight / 8,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on_sharp,
                                    size: 40,
                                  ),
                                  title: Text(
                                    human?.province.toString() ?? 'Null',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(human?.subTitle ?? 'Null'),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Container(
              child: Card(
                child: const Text("Temel Yardım Taleplerim",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                color: Colors.red[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(20),
              ),
              width: deviceWidth,
            ),
            Expanded(
              child: FutureBuilder<List<BasisAidData>?>(
                  future: BasisAidService.getBasisAidDataByUserId(),
                  builder: (context, snapshot) {
                    var basisAidData = snapshot.data;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: basisAidData?.length,
                        itemBuilder: (context, index) {
                          var basisAid = basisAidData?[index];
                          return InkWell(
                            onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BasisAidDetailByUser(
                                        id: basisAid!.id.toString(),
                                      )))
                            },
                            child: Card(
                              child: SizedBox(
                                width: deviceWidth,
                                height: deviceHeight / 8,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on_sharp,
                                    size: 40,
                                  ),
                                  title: Text(
                                    basisAid?.province.toString() ?? 'Null',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(basisAid?.subTitle ?? 'Null'),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
