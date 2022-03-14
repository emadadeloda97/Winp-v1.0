import 'package:flutter/material.dart';
import 'package:oda_tables/GetX/controller/Controllers.dart';
import 'package:oda_tables/GetX/views/SellPlaces.dart';
import 'package:oda_tables/GetX/views/db_test.dart';
import 'package:oda_tables/GetX/views/comp.dart';
import 'package:get/get.dart';
import 'GetX/views/whatYouSell.dart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
void main() async {
  runApp(const MyApp());
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(DBCont(), tag: 'database');
    Get.put(MyInfo(), tag: 'MyInfo');
    Get.put(MyTabController(), tag: 'controller');
    return GetMaterialApp(
      initialRoute: '/',
      home: MainScreen(myInfo: myInfo),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class RouteScreen extends StatelessWidget {
  RouteScreen({Key? key}) : super(key: key);
  final MyInfo myInfo = Get.find(tag: 'MyInfo');
  final MyTabController tabBarCont = Get.find(tag: 'controller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        bottom: TabBar(
          indicator: BoxDecoration(
              color: (myInfo.isDark)
                  ? const Color.fromARGB(255, 175, 171, 165)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30))),
          isScrollable: true,
          labelStyle: ArabicStyle(
              fontSize: 20, color: const Color.fromARGB(255, 54, 42, 218)),
          labelColor: const Color.fromARGB(255, 54, 42, 218),
          unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
          unselectedLabelStyle: ArabicStyle(fontSize: 10),
          controller: tabBarCont.controller,
          tabs: tabBarCont.myTabs,
          onTap: (x) {
            tabBarCont.changeCurrentIndex(x);
            myInfo.updateItemList();
            myInfo.updateItemsNames();
          },
        ),
        toolbarHeight: 80,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                gradient: (myInfo.isDark)
                    ? AppBarGradientDark()
                    : AppBarGradientLight())),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: (myInfo.isDark)
                    ? const Color.fromARGB(255, 175, 171, 165)
                    : const Color.fromARGB(255, 255, 255, 255),
                width: 0),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(15))),
        title: Obx(() => tabBarCont.AppBarTitleChanger(myInfo.now.value)),
      ),
      body: TabBarView(
        controller: tabBarCont.controller,
        children: [
          const DB_test(),
          WhatYouSell(),
          const SellPlaces(),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.myInfo,
  }) : super(key: key);

  final MyInfo myInfo;
  final MediaQueryData _media = const MediaQueryData();

  @override
  Widget build(BuildContext context) {
    final MyTabController tabBarCont = Get.find(tag: 'controller');

    return Scaffold(
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                gradient: (myInfo.isDark)
                    ? AppBarGradientDark()
                    : AppBarGradientLight())),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        title: Obx(() => (myInfo.isDark)
            ? Text('مسامسا',
                style: ArabicStyle(
                    color: const Color.fromARGB(255, 239, 239, 241),
                    fontSize: 35 * _media.textScaleFactor,
                    weight: FontWeight.w700))
            : Text('صبح صبح',
                style: ArabicStyle(
                    color: const Color.fromARGB(255, 239, 239, 241),
                    fontSize: 35 * _media.textScaleFactor,
                    weight: FontWeight.w700))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 7, 218, 255),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                    color: const Color.fromARGB(255, 14, 95, 175), width: 8),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 7, 218, 255),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  Get.to(() => RouteScreen());
                  tabBarCont.controller.index = 0;
                },
                child: Text('المبيع اليومي',
                    style: ArabicStyle(
                        fontSize: 50 * _media.textScaleFactor,
                        color: const Color.fromARGB(255, 14, 95, 175),
                        weight: FontWeight.w700)),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 7, 218, 255),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                    color: const Color.fromARGB(255, 14, 95, 175), width: 8),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 7, 218, 255),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  Get.to(
                    () => RouteScreen(),
                  );

                  tabBarCont.controller.index = 1;
                  myInfo.updateItemList();
                  myInfo.updateItemsNames();
                },
                child: Text(
                  'الحاجات الي بتبعها',
                  style: ArabicStyle(
                      fontSize: 50 * _media.textScaleFactor,
                      color: const Color.fromARGB(255, 14, 95, 175),
                      weight: FontWeight.w700),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 7, 218, 255),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(
                    color: const Color.fromARGB(255, 14, 95, 175), width: 8),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // padding: const EdgeInsets.all(20),
                  primary: const Color.fromARGB(255, 7, 218, 255),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  Get.to(
                    () => RouteScreen(),
                  );
                  myInfo.updateItemsNames();
                  tabBarCont.controller.index = 2;
                  // myInfo.updateShopList();
                },
                child: Text('أماكن البيع',
                    style: ArabicStyle(
                        fontSize: 50 * _media.textScaleFactor,
                        color: const Color.fromARGB(255, 14, 95, 175),
                        weight: FontWeight.w700)),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(50),
                  primary: const Color.fromARGB(0, 253, 253, 253),
                  shadowColor: const Color.fromARGB(0, 253, 253, 253),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  Get.to(() => const DB_test());
                },
                child: Text('Test',
                    style: ArabicStyle(
                        fontSize: 50 * _media.textScaleFactor,
                        color: const Color.fromARGB(255, 14, 95, 175),
                        weight: FontWeight.w700)))
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////


//TODO: make remove Shop Item Screen
//TODO: make Edit Shop Item Screen
//TODO: make Daily Screen
