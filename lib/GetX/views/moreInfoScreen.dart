// ignore_for_file: file_names, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/controller/Controllers.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:oda_tables/GetX/views/comp.dart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class moreItemInfo extends StatelessWidget {
  static String routeName = '/moreItemInfo';
  const moreItemInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    print("moreInfoEnter");
    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 210, 203, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "معلومات اكتر",
          style: ArabicStyle(),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: containerDecoration(),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'اسم الصنف : ',
                      style: ArabicStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${data[ItemFiled.ItemName]}',
                            style: ArabicStyle(
                                fontSize: 25, weight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' الباقي في المخزن: ',
                      style: ArabicStyle(fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${data[ItemFiled.StockNum]}",
                            style: ArabicStyle(
                                fontSize: 25, weight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      // width: double.infinity,
                      margin: const EdgeInsets.all(8),
                      decoration: containerDecoration(),
                      child: Column(
                        children: [
                          Text(
                            "سعر البيع : ",
                            style: ArabicStyle(fontSize: 20),
                          ),
                          Text('${data[ItemFiled.StockPrice]}',
                              style: ArabicStyle(
                                  fontSize: 25, weight: FontWeight.bold))
                        ],
                      )),
                ),
                Expanded(
                  child: Container(
                      // width: double.infinity,
                      margin: const EdgeInsets.all(8),
                      decoration: containerDecoration(),
                      child: Column(
                        children: [
                          Text(
                            "سعر الجمله : ",
                            style: ArabicStyle(fontSize: 20),
                          ),
                          Text('${data[ItemFiled.SellPrice]}',
                              style: ArabicStyle(
                                  fontSize: 25, weight: FontWeight.bold))
                        ],
                      )),
                ),
              ],
            ),
            const Divider(
              indent: 2,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
///
///
///
///
class MoreInfoShopItemList extends StatelessWidget {
  final List data;
  final String shopName;

  // final DBCont dbCont = Get.find(tag: 'database');

  MoreInfoShopItemList({Key? key, required this.data, required this.shopName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amont = TextEditingController();

    final MyInfo myInfo = Get.find(tag: 'MyInfo');

    return Scaffold(
        backgroundColor: (myInfo.isDark)
            ? const Color.fromARGB(255, 175, 171, 165)
            : const Color.fromARGB(255, 255, 255, 255),
        appBar: MyAppBar(
          myInfo: myInfo,
          title: Text(
            'معلومات اكتر',
            style: ArabicStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: containerDecoration(),
              child: Text(
                shopName,
                style: ArabicStyle(),
              ),
            ),
            Text(
              " قائمة السلع : ",
              style: ArabicStyle(),
              textDirection: TextDirection.rtl,
            ),
            const Divider(
              color: Colors.black,
              endIndent: 25,
              indent: 25,
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemList_ShopList_Card(data: data[index]);
                },
              ),
            ),
          ],
        ));
  }
}

// ignore: camel_case_types
class ItemList_ShopList_Card extends StatelessWidget {
  ItemList_ShopList_Card({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;
  final MyInfo myInfo = Get.find(tag: 'MyInfo');

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: containerDecoration(),
        child: Column(
          children: [
            Text(
              '${data["ItemName"]}',
              style: ArabicStyle(),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        " في المكان : ",
                        style: ArabicStyle(),
                      ),
                      Text('${data['Remind']}', style: ArabicStyle())
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "المباع : ",
                        style: ArabicStyle(),
                      ),
                      Text('${data['Selled']}', style: ArabicStyle())
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "المكسب : ",
                        style: ArabicStyle(),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: (() {
                            myInfo.updateSeeMaksab();
                          }),
                          child: Container(
                            child: myInfo.sellMaksab.value
                                ? Text('${data['Selled'] * data['SellPrice']}',
                                    style: ArabicStyle())
                                : const Icon(
                                    Icons.visibility_off_rounded,
                                    size: 40,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
