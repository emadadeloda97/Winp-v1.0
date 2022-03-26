// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:WINP/GetX/models/database_entity.dart';
import 'package:WINP/GetX/views/SellPlaces.dart';
import 'package:WINP/GetX/views/comp.dart';

import '../controller/Controllers.dart';

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
                                      child: SizedBox(
                                          width: 100, child: Text(element)),
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
              () => Expanded(
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

/*     DAILY INPUT SCREEN            */
class InputDailyRecord extends StatelessWidget {
  const InputDailyRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return Scaffold(
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      appBar: MyAppBar(
          myInfo: myInfo,
          title: Text(
            'اضافة تسجيل',
            style: ArabicStyle(color: Colors.white, fontSize: 35),
          )),
      bottomNavigationBar: _MyBottomAppBarr(myInfo),
      body: _MyBody(context),
    );
  }

  MyBottomAppBar _MyBottomAppBarr(MyInfo myInfo) {
    return MyBottomAppBar(
      myInfo: myInfo,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                for (var i = 0; i < myInfo.ShopsNames.length; i++) {
                  if (myInfo.selectedItemText[i] != '') {
                    for (var item
                        in myInfo.selectedItemText[i].toString().split('\n')) {
                      var amount = item.split(":")[1];
                      var name = item.split(":")[0];
                      var x = DBDailySell(
                          Date: myInfo.dateSelected.value.text,
                          ItemName: name,
                          ShopName: myInfo.ShopsNames[i],
                          Selld: int.parse(amount));
                      int r = await DBDailySell.insertRow(x);
                      if (r == 1) {
                        TextToast.show('تم', bgc: Colors.green);
                      } else {
                        TextToast.show(
                            '${item.split(":")[0]} ${myInfo.ShopsNames[i]} راجع البيانات',
                            bgc: Colors.red);
                      }
                      print(x.toJSON());
                      print(item.split(":")[0]);
                    }
                  }
                  Get.back();
                }
                // Get.back();
                // print(myInfo.selectedItemText);
              }),
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
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Container _MyBody(context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: containerDecoration(),
      child: Column(
        children: [
          const BasicDateField(),
          Expanded(
            child: ListView.builder(
              itemCount: myInfo.ShopsNames.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    myInfo.updateIsExpanted(index, myInfo.ShopsNames[index],
                        myInfo.isExpantedInputAmountScreen[index]);
                  },
                  child: _MyDailyInputCard(
                    index: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MyDailyInputCard extends StatelessWidget {
  const _MyDailyInputCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    TextEditingController amountSelld = TextEditingController();
    return Obx(
      () => Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 87, 171, 240),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      myInfo.ShopsNames[index],
                      style: ArabicStyle(),
                    ),
                    myInfo.isExpantedInputAmountScreen[index]
                        ? const Icon(Icons.arrow_drop_up, size: 40)
                        : const Icon(Icons.arrow_drop_down, size: 40)
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                myInfo.isExpantedInputAmountScreen[index]
                    ? Container(
                        constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: myInfo.itemShopList
                                    .map((element) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: InputChip(
                                              label: Text(
                                                '${element['ItemName']}',
                                                style: ArabicStyle(),
                                              ),
                                              onPressed: () {
                                                Get.defaultDialog(
                                                    content: Column(
                                                      children: [
                                                        Text(
                                                          element['ItemName'],
                                                          style: ArabicStyle(),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                                  label: Text(
                                                                    'الكمية',
                                                                    style:
                                                                        ArabicStyle(),
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder()),
                                                          controller:
                                                              amountSelld,
                                                        )
                                                      ],
                                                    ),
                                                    onConfirm: () {
                                                      myInfo.updateSelectedItemText(
                                                          '${element['ItemName']}',
                                                          amountSelld.text,
                                                          index);
                                                      Get.back();
                                                      amountSelld.text = '';
                                                    });
                                              }),
                                        ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxHeight: double.infinity,
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 194, 192, 192)),
                              child: Text(
                                myInfo.selectedItemText[index],
                                style: ArabicStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  for (var item in myInfo
                                      .selectedItemText[index]
                                      .split('\n')) {
                                    print(item);
                                  }
                                  myInfo.removeSelectedItemText(index);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          )),
    );
  }
}
