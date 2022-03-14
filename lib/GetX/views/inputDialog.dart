// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:oda_tables/GetX/views/SellPlaces.dart';
import 'package:oda_tables/GetX/views/comp.dart';
import 'package:oda_tables/main.dart';

import '../controller/Controllers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';

///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
Future<dynamic> InputItemDialog() {
  return Get.defaultDialog(
    title: "أضافه صنف جديد في المخزن",
    titleStyle: ArabicStyle(fontSize: 30),
    content: Directionality(
        textDirection: TextDirection.rtl, child: InputItemTextField()),
  );
}

class InputItemTextField extends StatelessWidget {
  final ItemNameCtrl = TextEditingController();
  final StockNumCtrl = TextEditingController();
  final StrocPriceCtrl = TextEditingController();
  final SellPriceCtrl = TextEditingController();
  final MyInfo myInfo = Get.find(tag: 'MyInfo');

  InputItemTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: ArabicStyle(fontSize: 20),
            controller: ItemNameCtrl,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(
                  'اسم الصنف',
                  style:
                      ArabicStyle(color: const Color(0xff2196f3), fontSize: 32),
                )),
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: ArabicStyle(fontSize: 20),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: StockNumCtrl,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      'الكميه',
                      style: ArabicStyle(
                          color: const Color(0xff2196f3), fontSize: 20),
                    )),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: ArabicStyle(fontSize: 20),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: StrocPriceCtrl,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      'سعر الجملة',
                      style: ArabicStyle(
                          color: const Color(0xff2196f3), fontSize: 20),
                    )),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: ArabicStyle(fontSize: 20),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: SellPriceCtrl,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      'سعر البيع',
                      style: ArabicStyle(
                          color: const Color(0xff2196f3), fontSize: 20),
                    )),
              ),
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () async {
                try {
                  final data = DBItem(
                      ItemName: ItemNameCtrl.text,
                      StockNum: int.parse(StockNumCtrl.text),
                      StockPrice: double.parse(StrocPriceCtrl.text),
                      SellPrice: double.parse(SellPriceCtrl.text));
                  await DBItem.insert(data);
                  Get.back();
                  myInfo.updateItemList();
                  print('done');
                  TextToast.show("تم اضافة ${ItemNameCtrl.text}",
                      bgc: Colors.green, duration: 3);

                  // myInfo.updateItemList();
                } catch (e) {
                  TextToast.show("فشل  ${ItemNameCtrl.text}/n راجع البيانات",
                      bgc: Colors.red, duration: 1);
                }
              },
              child: Text(
                "حفظ",
                style: ArabicStyle(),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Get.back();
              },
              child: Text(
                "الغاء",
                style: ArabicStyle(),
              ),
            )
          ],
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// Future<dynamic> InputShopDialog() {
//   final MyInfo myInfo = Get.find(tag: 'MyInfo');

//   return Get.defaultDialog(
//     backgroundColor: (myInfo.isDark)
//         ? const Color.fromARGB(255, 175, 171, 165)
//         : const Color.fromARGB(255, 255, 255, 255),
//     title: "أضافه مكان جديد",
//     titleStyle: ArabicStyle(
//         fontSize: 35, color: Colors.blue[800], weight: FontWeight.w700),
//     content: Directionality(
//         textDirection: TextDirection.rtl, child: InputShopTextField()),
//   );
// }

class InputShopScreen extends StatelessWidget {
  final ShopNameCtrl = TextEditingController();
  final amont = TextEditingController();

  final MyInfo myInfo = Get.find(tag: 'MyInfo');

  InputShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myInfo.updateItemsNames();
    myInfo.updateShopList();

    return Scaffold(
        backgroundColor: (myInfo.isDark)
            ? const Color.fromARGB(255, 175, 171, 165)
            : const Color.fromARGB(255, 255, 255, 255),
        appBar: MyAppBar(
          myInfo: myInfo,
          title: Text(
            'اضافة مكان',
            style: ArabicStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(
          myInfo: myInfo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(padding: const EdgeInsets.all(5)),
                label: Text('الغاء',
                    style: ArabicStyle(
                        fontSize: 30,
                        color: (myInfo.isDark)
                            ? const Color.fromARGB(255, 175, 171, 165)
                            : const Color.fromARGB(255, 45, 70, 184),
                        weight: FontWeight.w700)),
                icon: Icon(
                  Icons.disabled_by_default_outlined,
                  size: 30,
                  color: (myInfo.isDark)
                      ? const Color.fromARGB(255, 175, 171, 165)
                      : const Color.fromARGB(255, 45, 70, 184),
                ),
                onPressed: () {
                  myInfo.resetShopItemList();
                  Get.back();
                },
              ),
              TextButton.icon(
                  label: Text('حفظ',
                      style: ArabicStyle(
                          fontSize: 30,
                          color: (myInfo.isDark)
                              ? const Color.fromARGB(255, 175, 171, 165)
                              : const Color.fromARGB(255, 45, 70, 184),
                          weight: FontWeight.w700)),
                  icon: Icon(
                    Icons.check_box,
                    size: 30,
                    color: (myInfo.isDark)
                        ? const Color.fromARGB(255, 175, 171, 165)
                        : const Color.fromARGB(255, 45, 70, 184),
                  ),
                  onPressed: () async {
                    if (myInfo.SelectecItemsList.isNotEmpty &&
                        ShopNameCtrl.text != '') {
                      for (var item in myInfo.SelectecItemsList) {
                        print(item);
                        if (item.toString().split('|')[1] == 'true') {
                          String r = await DBShopItemsList.insertFromStock(
                              DBShopItemsList(
                                  ItemName: item.toString().split('|')[0],
                                  ShopName: ShopNameCtrl.text,
                                  Remind:
                                      int.parse(item.toString().split('|')[2]),
                                  Selld: 0));

                          if (r == 'Done') {
                            TextToast.show(
                                "تم اضافة ${item.toString().split('|')[0]}",
                                duration: 3,
                                bgc: Colors.green);
                          } else {
                            TextToast.show(
                                "فشل ${item.toString().split('|')[0]}",
                                duration: 3,
                                bgc: Colors.green);
                          }
                        } else {
                          int r = await DBShopItemsList.insert(DBShopItemsList(
                              ItemName: item.toString().split('|')[0],
                              ShopName: ShopNameCtrl.text,
                              Remind: int.parse(item.toString().split('|')[2]),
                              Selld: 0));
                          if (r == 1) {
                            TextToast.show(
                                "تم اضافة ${item.toString().split('|')[0]}",
                                duration: 3,
                                bgc: Colors.green);
                          } else {
                            TextToast.show(
                                "فشل ${item.toString().split('|')[0]}",
                                duration: 3,
                                bgc: Colors.green);
                          }
                        }
                      }

                      Get.back();
                      myInfo.updateShopList();
                    } else {
                      TextToast.show("راجع البيانات", bgc: Colors.red);
                    }
                  }),
            ],
          ),
        ),
        body: Column(children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: TextField(
                style: ArabicStyle(fontSize: 25),
                controller: ShopNameCtrl,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.blue)),
                    label: Text(
                      'اسم المكان',
                      style: ArabicStyle(
                          color: const Color(0xff2196f3), fontSize: 32),
                    )),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: containerDecoration(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          'اسم الصنف',
                          style: ArabicStyle(),
                        ),
                      ),
                      Expanded(
                        child: Obx(() => DropdownButton(
                            value: myInfo.ItemSelectedName.value,
                            items: myInfo.ItemsNames.map(
                                (element) => DropdownMenuItem(
                                      child: Text(element),
                                      value: element,
                                    )).toList(),
                            onChanged: (v) => myInfo.updateItemSelected(v))),
                      ),
                      Expanded(
                          child: TextField(
                        controller: amont,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: 'الكمية',
                            labelStyle: ArabicStyle(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'من المخزن',
                          style: ArabicStyle(fontSize: 20),
                        ),
                      ),
                      Obx(
                        () => Checkbox(
                            value: myInfo.fromStock.value,
                            onChanged: (v) {
                              myInfo.updateFromStockValue(v);
                            }),
                      ),
                      TextButton.icon(
                          label: Text(
                            'اضافة الي القائمة',
                            style: ArabicStyle(fontSize: 20),
                          ),
                          icon: const Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (amont.text != '' &&
                                myInfo.ItemSelectedName.value != '') {
                              myInfo.addItemToSelectedList(
                                  myInfo.ItemSelectedName.value,
                                  amont.text,
                                  myInfo.fromStock.value);
                            }
                            print(myInfo.SelectecItemsList);
                          })
                    ],
                  )
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Obx(
              () => ConstrainedBox(
                constraints:
                    BoxConstraints.loose(const Size(double.infinity, 200)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...myInfo.SelectecItemsList.map((element) => Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(element),
                                IconButton(
                                    onPressed: (() {
                                      myInfo.SelectecItemsList.remove(element);
                                      myInfo.ItemsNames.add(
                                          element.toString().split('|')[0]);
                                      print(element);
                                    }),
                                    icon: const Icon(
                                      Icons.remove_circle_outline_outlined,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
