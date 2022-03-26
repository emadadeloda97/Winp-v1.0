// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:WINP/GetX/controller/Controllers.dart';
import 'package:WINP/GetX/models/database_entity.dart';
import 'package:WINP/GetX/views/inputDialog.dart';

import 'comp.dart';

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
                      data: myInfo.dailyRecord.keys.toList()[index],
                      index: index);
                }),
      ),
      floatingActionButton: FloatingActionBtn(myInfo),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
  const DailyRecordCard({Key? key, required this.data, required this.index})
      : super(key: key);
  final String data;
  final int index;

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: containerDecoration(),
      child: GestureDetector(
        onTap: () {
          myInfo.updateIsExpantedDailyRecord(
              index, myInfo.isExpantedDailyRecord[index]);
        },
        child: Card(
          elevation: 0,
          color: Colors.blue[50],
          child: Obx(
            () => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      data,
                      style: ArabicStyle(fontSize: 30),
                    ),
                    IconButton(
                        onPressed: () async {
                          myInfo.updateIsExpantedDailyRecord(
                              index, myInfo.isExpantedDailyRecord[index]);
                        },
                        icon: myInfo.isExpantedDailyRecord[index]
                            ? const Icon(
                                Icons.arrow_drop_up_rounded,
                                size: 40,
                              )
                            : const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 40,
                              ))
                  ],
                ),
                myInfo.isExpantedDailyRecord[index]
                    ? Column(
                        children: [
                          SizedBox(
                              height: myInfo.dailyRecord[data].length * 50.0,
                              child: ListView.builder(
                                itemCount: myInfo.dailyRecord[data].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    '${myInfo.dailyRecord[data][index]['Selled']} من ${myInfo.dailyRecord[data][index]['ItemName']} في ${myInfo.dailyRecord[data][index]['ShopName']}',
                                    style: ArabicStyle(),
                                    textAlign: TextAlign.center,
                                  );
                                },
                              )),
                          IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  middleText: 'مسح سجل اليوم؟',
                                  middleTextStyle: ArabicStyle(),
                                  textCancel: 'الغاء',
                                  textConfirm: 'تم',
                                  onConfirm: () async {
                                    for (var item in myInfo.dailyRecord[data]) {
                                      await DBDailySell.rollback(
                                          date: item['Date'],
                                          item: item['ItemName'],
                                          shop: item['ShopName']);
                                    }
                                    TextToast.show('تم المسح');
                                    Get.back();
                                    myInfo.setDailyRecords();
                                  });
                            },
                            iconSize: 40,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              semanticLabel: 'مسح الكل',
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
