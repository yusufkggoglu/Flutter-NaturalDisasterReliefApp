import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/humane_aid_add.dart';
import 'package:flutter_application_1/humane_aid_list_by_user.dart';
import 'package:hexcolor/hexcolor.dart';

class UserInterface extends StatefulWidget {
  const UserInterface({super.key});

  @override
  State<UserInterface> createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> {
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
                            titleAlignment: ListTileTitleAlignment.center,
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
                  ],
                ),
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
                            titleAlignment: ListTileTitleAlignment.center,
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
                ),
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
                            titleAlignment: ListTileTitleAlignment.center,
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
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const HumaneAidListByUser(id: "string1")))
                      },
                      child: Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: deviceWidth,
                          // height: deviceHeight / 8,
                          child: const ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
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
                  ],
                ),
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
                            titleAlignment: ListTileTitleAlignment.center,
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
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HumaneAidAdd()))
                      },
                      child: Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: deviceWidth,
                          // height: deviceHeight / 8,
                          child: const ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
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
                  ],
                ),
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
                            titleAlignment: ListTileTitleAlignment.center,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
