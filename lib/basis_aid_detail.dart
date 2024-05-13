import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/models/basis_aid_create_response_model.dart';
import 'package:flutter_application_1/services/basis_aid_service.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class BasisAidDetail extends StatefulWidget {
  final String id;

  const BasisAidDetail({super.key, required this.id});

  @override
  State<BasisAidDetail> createState() => _BasisAidDetailState();
}

class _BasisAidDetailState extends State<BasisAidDetail> {
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
                            "Temel Yardım Talebi",
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
                    child: FutureBuilder<BasisAidSingleData?>(
                        future: BasisAidService.getByIdBasisAidData(widget.id),
                        builder: (context, snapshot) {
                          var basisAidData = snapshot.data;
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Ad Soyad',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    basisAidData!.name.toString(),
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
                                    basisAidData.phone.toString(),
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
                                    basisAidData.province.toString(),
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
                                    basisAidData.district.toString(),
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
                                    basisAidData.neighborhood.toString(),
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
                                    basisAidData.address.toString(),
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
                                      launch(basisAidData.locationUrl
                                          .toString()); // basisAidData.locationUrl burada tıklanabilir URL'yi içermelidir
                                    },
                                    child: Text(
                                      basisAidData.locationUrl.toString(),
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
                                    'İstenilen Yardım',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    basisAidData.subTitle.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Adet',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    basisAidData.amount.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'İstenilen Yardım Açıklaması',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    basisAidData.description.toString(),
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
                                    basisAidData.createdTime.toString(),
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
}
