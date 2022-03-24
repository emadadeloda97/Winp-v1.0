// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/controller/Controllers.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:intl/intl.dart';
import 'package:oda_tables/GetX/views/comp.dart';

import 'inputDialog.dart';

class DailySellScreen extends StatelessWidget {
  const DailySellScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    myInfo.updateShopList();
    myInfo.setDailyRecords();
    myInfo.updateShopList();
    return Scaffold(
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      body: Obx(
        () => myInfo.dailyRecord.length == 0
            ? Center(
                child: Text(
                '''مفيش حاجة لسة اعمل اضافة من تحت ''',
                style: ArabicStyle(),
              ))
            : ListView.builder(
                itemCount: myInfo.dailyRecord.length,
                itemBuilder: (BuildContext context, int index) {
                  return DailyRecordCard(
                    data: myInfo.dailyRecord[index],
                  );
                }),
      ),
      floatingActionButton: FloatingActionBtn(myInfo),
    );
  }
}

FloatingActionButton FloatingActionBtn(MyInfo myInfo) {
  return FloatingActionButton.extended(
    onPressed: () {
      myInfo.updateShopList();
      myInfo.setDailyRecords();
      Get.to(() => const InputDailyRecord());
    },
    label: Text('اضافة تسجيل',
        style: ArabicStyle(
            fontSize: 30,
            color: (myInfo.isDark)
                ? const Color.fromARGB(255, 175, 171, 165)
                : const Color.fromARGB(255, 45, 70, 184),
            weight: FontWeight.w700)),
    icon: Icon(
      Icons.add_circle_outline_outlined,
      size: 30,
      color: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 45, 70, 184),
    ),
    backgroundColor: const Color.fromRGBO(93, 100, 150, 1),
  );
}

class DailyRecordCard extends StatelessWidget {
  const DailyRecordCard({Key? key, required this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: containerDecoration(),
      child: Card(
        elevation: 0,
        color: Colors.blue[50],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  data['Date'],
                  style: ArabicStyle(fontSize: 30),
                ),
                IconButton(
                    onPressed: () async {
                      await DBDailySell.readByDate(date: data['Date']);
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      size: 40,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
