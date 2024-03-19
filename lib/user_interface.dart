// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/basis_aid_add.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/constants/identity.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/humane_aid_add.dart';
import 'package:flutter_application_1/user_aids_list.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/services/identity_server_service.dart';
import 'package:hexcolor/hexcolor.dart';

class UserInterface extends StatefulWidget {
  const UserInterface({super.key});

  @override
  State<UserInterface> createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> {
  bool? auth;
  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    auth = await IdentityServerService.checkAuth();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

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
                            "Kullanıcı Arayüzü",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F2F3E)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Giriş yapmadıysa

                Container(
                    child: auth == null
                        ? const Center(
                            child:
                                CircularProgressIndicator()) // Yükleme göster
                        : auth == false // Giriş yapılmamışsa
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register()))
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.add_reaction_rounded,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'Kayıt Ol',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()))
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.login,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'Giriş Yap',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            :
                            // Giriş yaptıysa
                            Column(
                                children: [
                                  InkWell(
                                    onTap: () => {},
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.settings,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'Kullanıcı Ayarları',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HumaneAidListByUser(
                                                      id: "string1")))
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.list,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'Yardım Taleplerim',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BasisAidAdd()))
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.add_sharp,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'Temel Yardım Talebinde Bulun',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HumaneAidAdd()))
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.accessibility_new_rounded,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'İnsani Yardım Talebinde Bulun',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async => {
                                      await IdentityServerService
                                          .deleteSecureData(SECURE_NOTE_KEY),
                                      auth = false,
                                      setState(() {}),
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.green,
                                            content: Text('Çıkış Yapıldı')),
                                      ),
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                          (route) => false)
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: SizedBox(
                                        width: deviceWidth,
                                        // height: deviceHeight / 8,
                                        child: const ListTile(
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                          leading: Icon(
                                            Icons.exit_to_app_sharp,
                                            size: 40,
                                          ),
                                          title: Text(
                                            'Çıkış',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
