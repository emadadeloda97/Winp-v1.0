// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:WINP/GetX/controller/Controllers.dart';
import 'package:WINP/GetX/models/database_entity.dart';
import 'package:WINP/GetX/views/comp.dart';
import 'package:WINP/GetX/views/inputDialog.dart';
import 'package:WINP/GetX/views/removeDialog.dart';
import 'EditDialog.dart';
import 'moreInfoScreen.dart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class WhatYouSell extends StatelessWidget {
  // final DBCont dbCont = Get.find(tag: 'database');

  const WhatYouSell({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    print("whatYouSellEnter");
    // myInfo.updateItemList();
    return Scaffold(
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (myInfo.ItemList.isEmpty) {
                return Center(
                    child: Column(
                  children: [
                    Text(
                      'اعمل اضافة من تحت',
                      style: ArabicStyle(fontSize: 40),
                    ),
                    const Icon(
                      Icons.arrow_downward,
                      size: 45,
                    ),
                  ],
                ));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: myInfo.ItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SmallItemCard(
                        data: myInfo.ItemList[index],
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        myInfo: myInfo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(
                Icons.add_circle_outline_outlined,
                size: 30,
                color: (myInfo.isDark)
                    ? const Color.fromARGB(255, 175, 171, 165)
                    : const Color.fromARGB(255, 45, 70, 184),
              ),
              onPressed: () {
                InputItemDialog();
              },
              label: Text('اضافة',
                  style: ArabicStyle(
                      fontSize: 30,
                      color: (myInfo.isDark)
                          ? const Color.fromARGB(255, 175, 171, 165)
                          : const Color.fromARGB(255, 45, 70, 184),
                      weight: FontWeight.w700)),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(padding: const EdgeInsets.all(5)),
              onPressed: () {
                RemoveItemDialog();
              },
              icon: Icon(
                Icons.remove_circle_outline_outlined,
                size: 30,
                color: (myInfo.isDark)
                    ? const Color.fromARGB(255, 175, 171, 165)
                    : const Color.fromARGB(255, 45, 70, 184),
              ),
              label: Text('حذف',
                  style: ArabicStyle(
                      fontSize: 30,
                      color: (myInfo.isDark)
                          ? const Color.fromARGB(255, 175, 171, 165)
                          : const Color.fromARGB(255, 45, 70, 184),
                      weight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class SmallItemCard extends StatelessWidget {
  final Map data;

  const SmallItemCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: containerDecoration(),
      child: Column(
        children: [
          Text(
            '${data[ItemFiled.ItemName]}',
            style: ArabicStyle(fontSize: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'في المخزن : ${data[ItemFiled.StockNum]}',
                style: ArabicStyle(fontSize: 20),
              ),
              Text(
                'الجملة : ${data[ItemFiled.StockPrice]}',
                style: ArabicStyle(fontSize: 20),
              ),
              Text(
                'البيع : ${data[ItemFiled.SellPrice]}',
                style: ArabicStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => EditItemDialog(data),
                  child: Text(
                    'تعديل',
                    style: ArabicStyle(fontSize: 20),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const moreItemInfo(), arguments: data);
                  },
                  child: Text(
                    'معلومات اكنر',
                    style: ArabicStyle(fontSize: 20),
                  ))
            ],
          ),
        ],
      ),
    ));
  }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////