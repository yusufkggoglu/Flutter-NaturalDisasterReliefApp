import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:flutter_application_1/user_interface.dart';
import 'package:hexcolor/hexcolor.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
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
                            "Bilinçlenme ve Önlem",
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
                        Image(image: AssetImage('lib/assets/images/foto1.jpg')),
                        ListTile(
                          title: Text(
                            'Depremden Korunma Yolları',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Deprem herkesi korkutan ve endişelendiren bir konu. En etkin fay hatlarından biri olan Akdeniz-Alp-Himalaya kuşağında bulunduğumuzu göz önünde bulundurursak çok da haksız sayılmayız. Fakat bu konuda hiçbir adım atmayıp sürekli deprem korkusu ile yaşayarak vakit geçmez. Deprem her ne kadar bizim dışımızda meydana gelen bir doğal afet olsa da, önlemlerimizi alıp etkisini azaltmamız mümkün. Depreme karşı önlem olarak: ',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Öncesinde',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Dolap, kütüphane gibi devrilme riski olan eşyaları duvara sabitlenmeli. Arada boşluk kalıyorsa çarpma etkisini azaltmak için araları dolgu malzemesi ile doldurulmalı.\n● Tavan ya da duvara asılan avize, klima gibi cihazları ağırlıklarını taşıyacak şekilde duvar ve pencerelerden uzağa sağlam bir şekilde asılmalı.\n● Tezgah ya da masa üzerinde bulunan eşyaları, plastik ya da metal tutucularla sabitlenmeli.\n● Deprem çantası hazırlanmalı ve düzenli aralıklarla içindeki malzemeler kontrol edilmeli.\n● Karyolaların üzerinde ya da yanında ağır ve devrilebilecek eşyalar bulundurmaktan kaçınılmalı.\n● Ev sahibi iseniz Zorunlu Deprem Sigortası (DASK)​ yaptırmanız gerekir. Bu şekilde depremden kaynaklanan hasarları telafi edebilirsiniz.",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Deprem esnasında',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Deprem sırasında evde ya da kapalı bir alandaysanız sabitlenmemiş eşyalardan uzak durarak sağlam bir eşyanın yanına çömelip başınızı ve boynunuzu ellerinizle koruma altına alın. \n● Kibrit ya da çakmak yakmamalı elektrikli düğmelerden uzak durmalısınız. \n● Deprem sırasında açık alanda iseniz duvar tipleri, enerji hatları ve ağaçlardan uzak durun. Açık arazide çömelerek kendinizi koruma altına alın. \n● Depreme aracın içinde yakalandığınızda ise kendinizi ve başka araçları riske atmadan sağa yanaşıp sarsıntının geçmesini bekleyebilirsiniz.",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Selden Korunma Yolları',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Ülkemizde en çok can ve mal kaybına sebep olan doğal afetlerden biri de sel. Plansız şehirleşme, yeşil alanların hızla yok olması selden dolayı oluşabilecek riskleri artırıyor. Bu etkileri hafifletmek ve çeşitli önlemler almak elbette ki mümkün. Sele karşı alınacak önlemler ise: ",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Öncesinde',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Çevredeki yeşil alanlar korunmalı ve artırılmalı. \n● Sel tehlikesi bulunan alanlarda teraslama ve ağaçlandırma yapılmalı. \n● Çeşitli iletişim kanallarıyla gerekli uyarılar yapılmalı.",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Sel esnasında',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Yüksek ve güvenli bir yere ulaşmaya çalışmalısınız. Fakat bunu yaparken suyun içinden geçmemeye dikkat edin. Çünkü görünenden çok daha derin olabilir. \n● Sel sırasında araç içindeyseniz asla ileri doğru gitmeye çalışmayın. Aracın içini terk edip yüksek bir yere geçmek için çabalayın.",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Çığdan Korunma Yolları',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Eğimli araziler üzerinden yuvarlanan ve yuvarlandıkça büyüyen kar kütlesine çığ denir. Çığ kar yağışının ve engebenin fazla olduğu bitki örtüsünden yoksun yerlerde görülür. Çığ olayıyla karşılaşma ihtimalimizi az gördüğümüz için bu konudaki bilincimiz ise maalesef daha düşük. Oysaki çığ tehlikesine karşı:",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Öncesinde',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Yerleşim yeri olarak çığ riski taşıyan bölgelerden kaçınılmalı.\n● Yamaçlardaki bitki örtüsü ve ormanlar koruma altına alınmalı. \n● Kar yağışı olan zamanlarda haberler ve yol durumu dikkatle takip edilmeli. ",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Çığ esnasında',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Çığın büyüklüğü ve hızı dikkate alınarak güvenli bir bölgeye ulaşın.\n● Çığdan kaçmanız imkansız ise yerden destek alarak yüzme hareketleriyle yüzeyde kalmaya çalışın. \n● Başınızın karın altında kalma tehlikesine karşı ağzınızı sıkıca kapatın ve nefesinizi tutmaya çalışın.\n● Kar akışına kapılırsanız bacaklarınızı ve kollarınızı vücudunuza birleştirerek oturma pozisyonu almaya gayret edin. \n● Araç içindeyseniz motoru durdurup ışıkları söndürün. \n● Yanınızda fener varsa sizi görmeleri açısından kullanmanız faydalı olabilir. ",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            'Heyelandan Korunma Yolları',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Heyelan büyük ölçüdeki toprak ve kaya kaymalarına verilen isimdir. Ülkemiz aynı deprem ve sel gibi heyelan tehlikesini de barındırır. Özellikle yağışın ve eğimin fazla olduğu bölgelerde çok fazla görülen heyelanın bir doğal afete dönüşmemesi için önceden çeşitli önlemler alıp hem kendimizi hem de sevdiklerimizi koruyabiliriz. ",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Öncesinde',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Heyelan riskini azaltmak için arazi çalışmaları yapılmalı, risk olan bölgelerde yerleşimden uzak durulmalı. \n● Risk olan yamaçlarda doğal denge bozulmadan drenaj kanalları açılmalı, tabakların fazla su alınması önlenmeli. \n● Heyelan görülebilecek yamaçların eteklerine istinat duvarı inşa edilmeli. \n● Bitki ve toprak örtüsü korunmalı. ",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Heyelan esnasında',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "● Açık alandaysanız çamur ve heyelan akıntısından uzak durup yüksek yerlere kaçmaya çalışın. \n● Heyelan akıntısından kaçabilecek zamanınız yoksa ve kapalı alandaysanız sağlam eşyaların arkasına sığınarak çömelin, ellerinizle başınızı ve boynunuzu koruyun. ",
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
