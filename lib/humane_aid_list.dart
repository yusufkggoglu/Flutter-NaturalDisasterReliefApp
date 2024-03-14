import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/humane_aid_detail.dart';
import 'package:flutter_application_1/services/humane_aid_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

import 'models/humane_aid_model.dart';

class HumaneAid extends StatefulWidget {
  const HumaneAid({super.key});

  @override
  State<HumaneAid> createState() => _HumaneAidState();
}

class _HumaneAidState extends State<HumaneAid> {
  List<HumanData>? humanData;
  List<HumanData>? humanDataStorage;

  @override
  void initState() {
    super.initState();
    getHumanData();
    humanDataStorage = humanData;
  }

  Future<void> getHumanData() async {
    humanData = await HumaneAidService.getHumanData();
    setState(() {});
    humanDataStorage = humanData;
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
                        "İnsani Yardım",
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CupertinoSearchTextField(
                    onChanged: searchHumanData,
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ],
            ),
            Expanded(
                child: humanData != null
                    ? ListView.builder(
                        itemCount: humanData?.length,
                        itemBuilder: (context, index) {
                          var human = humanData?[index];
                          return InkWell(
                            onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HumaneAidDetail(
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
                    : const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  Future<void> searchHumanData(String query) async {
    var input = query.toLowerCase();
    final suggestions = humanData!.where((humanData) {
      final name = humanData.name!.toLowerCase();
      final address = humanData.address!.toLowerCase();
      final province = humanData.province!.toLowerCase();
      final district = humanData.district!.toLowerCase();
      final neighborhood = humanData.neighborhood!.toLowerCase();
      final description = humanData.description!.toLowerCase();
      final subTitle = humanData.subTitle!.toLowerCase();

      return name.contains(input) ||
          address.contains(input) ||
          province.contains(input) ||
          district.contains(input) ||
          neighborhood.contains(input) ||
          description.contains(input) ||
          subTitle.contains(input);
    }).toList();
    setState(() {
      if (input.isNotEmpty) {
        humanData = suggestions;
      } else {
        humanData = humanDataStorage;
      }
    });
  }
}
