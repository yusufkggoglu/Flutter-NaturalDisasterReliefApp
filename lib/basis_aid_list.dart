import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/basis_aid_detail.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/models/basis_aid_model.dart';
import 'package:flutter_application_1/services/basis_aid_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class BasisAid extends StatefulWidget {
  const BasisAid({super.key});

  @override
  State<BasisAid> createState() => _BasisAidState();
}

class _BasisAidState extends State<BasisAid> {
  List<BasisAidData>? basisAidData;
  List<BasisAidData>? basisAidDataStorage;

  @override
  void initState() {
    super.initState();
    getBasisAidData();
    basisAidDataStorage = basisAidData;
  }

  Future<void> getBasisAidData() async {
    basisAidData = await BasisAidService.getBasisAidData();
    setState(() {});
    basisAidDataStorage = basisAidData;
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
                        "Temel Yardım",
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
                    onChanged: searchBasisAidData,
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ],
            ),
            Expanded(
                child: basisAidData != null
                    ? ListView.builder(
                        itemCount: basisAidData?.length,
                        itemBuilder: (context, index) {
                          var basisAid = basisAidData?[index];
                          return InkWell(
                            onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BasisAidDetail(
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
                      )
                    : const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  Future<void> searchBasisAidData(String query) async {
    var input = query.toLowerCase();
    final suggestions = basisAidData!.where((basisAidData) {
      final name = basisAidData.name!.toLowerCase();
      final address = basisAidData.address!.toLowerCase();
      final province = basisAidData.province!.toLowerCase();
      final district = basisAidData.district!.toLowerCase();
      final neighborhood = basisAidData.neighborhood!.toLowerCase();
      final description = basisAidData.description!.toLowerCase();
      final subTitle = basisAidData.subTitle!.toLowerCase();

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
        basisAidData = suggestions;
      } else {
        basisAidData = basisAidDataStorage;
      }
    });
  }
}
