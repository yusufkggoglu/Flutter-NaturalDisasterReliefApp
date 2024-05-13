import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/models/user_info_model.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:flutter_application_1/user_change_password.dart';
import 'package:flutter_application_1/user_info_update.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
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
                            "Kullanıcı Bilgilerim",
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
                    child: FutureBuilder<UserInfo?>(
                        future: IdentityServerService.getAuthUser(),
                        builder: (context, snapshot) {
                          var data = snapshot.data;
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Ad',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    data!.name.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Soyad',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    data.surname.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Kullanıcı Adı',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    data.userName.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Email',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    data.email.toString(),
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
                                    data.phoneNumber.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    'Şehir',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    data.city.toString(),
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserInfoUpdate()))
                          },
                      child: SizedBox(
                        width: deviceWidth,
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "Kullanıcı Bilgilerini Güncelle",
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
                          backgroundColor: Colors.lightGreen),
                      onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const UserChangePassword()))
                          },
                      child: SizedBox(
                        width: deviceWidth,
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "Şifre Değiştir",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
