// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/controller/Controllers.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:intl/intl.dart';

class DailySellScreen extends StatelessWidget {
  const DailySellScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return Scaffold(
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          IconButton(
              onPressed: (() async {
                DateTime now = DateTime.now();
                String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                await DBDailySell.insertRow(DBDailySell(
                    Date: formattedDate,
                    ItemName: 'i1',
                    ShopName: 's1',
                    Selld: 50));
              }),
              icon: Icon(Icons.remove)),
          IconButton(
              onPressed: (() async {
                DateTime now = DateTime.now();
                String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                await DBDailySell.rollback(
                    date: formattedDate, item: 'i1', shop: 's1');
              }),
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
