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
  List<BasisAidData>? basisAidData;
  int? counterBasisAidData = 0;
  List<HumanData>? humaneAidData;
  int? counterHumaneAidData = 0;
  @override
  void initState() {
    super.initState();
    getBasisAidData();
    getHumaneAidData();
  }

  Future<void> getBasisAidData() async {
    basisAidData = await BasisAidService.getBasisAidDataByUserId();
    counterBasisAidData = basisAidData?.length;
    setState(() {});
  }

  Future<void> getHumaneAidData() async {
    humaneAidData = await HumaneAidService.getHumanDataByUserId();
    counterHumaneAidData = humaneAidData?.length;
    setState(() {});
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
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(20), // Margin eklendi
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5), // İçerik padding'i için
                        child: Text(
                          "İnsani Yardım Taleplerim (${counterHumaneAidData.toString()})",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      color: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    humaneAidData != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: humaneAidData?.length,
                            itemBuilder: (context, index) {
                              var human = humaneAidData?[index];
                              return InkWell(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          HumaneAidDetailByUser(
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
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    Card(
                      margin: const EdgeInsets.all(20), // Margin eklendi
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          "Temel Yardım Taleplerim (${counterBasisAidData.toString()})",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      color: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    basisAidData != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: basisAidData?.length,
                            itemBuilder: (context, index) {
                              var basisAid = basisAidData?[index];
                              return InkWell(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BasisAidDetailByUser(
                                            id: basisAid.id.toString(),
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
                                        basisAid!.province.toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      subtitle:
                                          Text(basisAid.subTitle.toString()),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
