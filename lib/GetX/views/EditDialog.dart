// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:oda_tables/GetX/models/database_helper.dart';
import 'package:oda_tables/GetX/views/SellPlaces.dart';
import 'package:oda_tables/GetX/views/comp.dart';

import '../controller/Controllers.dart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
Future<dynamic> EditItemDialog(Map data) {
  return Get.defaultDialog(
    title: "تعديل الصنف",
    titleStyle: ArabicStyle(fontSize: 35),
    content: Directionality(
        textDirection: TextDirection.rtl,
        child: EditItemTextField(
          data: data,
        )),
  );
}

class EditItemTextField extends StatelessWidget {
  final ItemNameCtrl = TextEditingController();
  final StockNumCtrl = TextEditingController();
  final StrocPriceCtrl = TextEditingController();
  final SellPriceCtrl = TextEditingController();
  final Map data;

  // final DBCont dbCont = Get.find(tag: 'database');

  EditItemTextField({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemNameCtrl.text = data[ItemFiled.ItemName];
    StockNumCtrl.text = data[ItemFiled.StockNum].toString();
    StrocPriceCtrl.text = data[ItemFiled.StockPrice].toString();
    SellPriceCtrl.text = data[ItemFiled.SellPrice].toString();
    return SizedBox(
      width: 500,
      child: Column(
        children: [
          // Text(
          //   "أضافه صنف جديد في المخزن",
          //   style: ArabicStyle(fontSize: 35),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: ArabicStyle(fontSize: 20),
              controller: ItemNameCtrl,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text(
                    'اسم الصنف',
                    style: ArabicStyle(
                        color: const Color(0xff2196f3), fontSize: 32),
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
                            color: const Color(0xff2196f3), fontSize: 32),
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
                            color: const Color(0xff2196f3), fontSize: 25),
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
                            color: const Color(0xff2196f3), fontSize: 25),
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
                    final newdata = {
                      'ItemName': ItemNameCtrl.text,
                      'StockNum': int.parse(StockNumCtrl.text),
                      'StockPrice': double.parse(StrocPriceCtrl.text),
                      'SellPrice': double.parse(SellPriceCtrl.text)
                    };
                    await DBItem.update(newdata, itemName: data['ItemName']);
                    Get.back();
                    print('done');
                    myInfo.updateItemList();
                    TextToast.show("تم تعديل ${ItemNameCtrl.text}",
                        bgc: Colors.green, duration: 3);

                    // await dbCont.read_all_item_table();
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
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Future<dynamic> EditShopDialog(Map data) async {
//   final MyInfo myInfo = Get.find(tag: 'MyInfo');
//   print(await DBShopItemsList.readAll());
//   return Get.defaultDialog(
//     title: "تعديل المكان",
//     titleStyle: ArabicStyle(fontSize: 35),
//     content: Directionality(
//         textDirection: TextDirection.rtl,
//         child: EditShopTextField(
//           data: data,
//         )),
//   );
// }

class EditShopItemList extends StatelessWidget {
  final String shopName;
  final List data;

  const EditShopItemList({Key? key, required this.shopName, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    final TextEditingController shopNameCtrl = TextEditingController();
    shopNameCtrl.text = shopName;
    List<String> add = [
      'من المخزن',
      'من برا',
    ];
    List<String> remove = [
      'للمخزن',
      'شيل خالص',
    ];
    return Scaffold(
      appBar: MyAppBar(
        myInfo: myInfo,
        title: Text(
          'تعديل بضاعة المكان',
          style: ArabicStyle(color: Colors.white),
        ),
      ),
      backgroundColor: (myInfo.isDark)
          ? const Color.fromARGB(255, 175, 171, 165)
          : const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: containerDecoration(),
              child: Obx(
                () => Row(
                  children: [
                    Text(
                      "اسم المكان : ",
                      style: ArabicStyle(),
                    ),
                    Expanded(
                        child: TextField(
                      controller: shopNameCtrl,
                      enabled: myInfo.renameShop.value,
                      textAlign: TextAlign.center,
                      style: ArabicStyle(fontSize: 15),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
                    Checkbox(
                        value: myInfo.renameShop.value,
                        onChanged: (_) => myInfo.updateRenameShop())
                  ],
                ),
              ),
            ),
          ),
          Text(
            " تعديل بالمجموعة : ",
            style: ArabicStyle(),
            textDirection: TextDirection.rtl,
          ),
          const Divider(
            color: Colors.black,
            endIndent: 25,
            indent: 25,
            thickness: 2,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: containerDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 206, 88, 80)),
                      child: Text("حذف", style: ArabicStyle(fontSize: 25)),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'شيل',
                  items: remove,
                  data: {},
                )),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'اضافة',
                  items: add,
                  data: {},
                )),
              ],
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
                return EditShopItemCard(
                  data: data[index],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          MyBottomAppBar(myInfo: myInfo, child: BottomBarRow()),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class EditShopItemCard extends StatelessWidget {
  final Map data;
  const EditShopItemCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    List<String> add = [
      'من المخزن',
      'من برا',
    ];
    List<String> remove = [
      'للمخزن',
      'شيل خالص',
    ];
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
                      Row(
                        children: [
                          Text(
                            "الباقي في المكان : ",
                            style: ArabicStyle(),
                          ),
                          Text('${data['Remind']}', style: ArabicStyle())
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 206, 88, 80)),
                      child: Text("حذف", style: ArabicStyle(fontSize: 25)),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'شيل',
                  items: remove,
                  data: data,
                )),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'اضافة',
                  items: add,
                  data: data,
                )),
              ],
            ),
          ],
        ));
  }
}

class EditShopItemDropDown extends StatelessWidget {
  final String hint;
  final List items;
  final Map data;
  const EditShopItemDropDown(
      {Key? key, required this.items, required this.hint, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(4)),
        // alignment: AlignmentDirectional.center,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            alignment: AlignmentDirectional.center,
            hint: Text(hint, style: ArabicStyle()),
            iconSize: 0,
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: ArabicStyle()),
                    ))
                .toList(),
            onChanged: (value) {
              switch (value) {
                case 'للمخزن':
                  {
                    final TextEditingController amount =
                        TextEditingController();
                    Get.defaultDialog(
                        middleText: '$data',
                        title: ' شيل  للمخزن \n${data['ItemName']}',
                        titleStyle: ArabicStyle(),
                        content: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                'هتشيل قد ايه : ',
                                style: ArabicStyle(),
                              ),
                              Expanded(
                                  child: TextField(
                                controller: amount,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ))
                            ],
                          ),
                        ));
                    removeFromItem(
                        itemName: 'itemName', toStock: true, amount: 100);
                  }
                  break;
                case 'شيل خالص':
                  {
                    removeFromItem(
                        itemName: 'itemName', toStock: false, amount: 100);
                  }
                  break;
                case 'من برا':
                  {
                    addToItem(
                        itemName: 'itemName', fromStock: false, amount: 100);
                  }
                  break;
                case 'من المخزن':
                  {
                    addToItem(
                        itemName: 'itemName', fromStock: true, amount: 100);
                  }
                  break;
              }
            },
            buttonElevation: 2,
            dropdownMaxHeight: 250,
            dropdownWidth: 250,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            buttonWidth: 350,
          ),
        ),
      ),
    );
  }
}

Row BottomBarRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton.icon(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(5)),
        label: Text('حذف',
            style: ArabicStyle(
                fontSize: 30,
                color: (myInfo.isDark)
                    ? const Color.fromARGB(255, 175, 171, 165)
                    : const Color.fromARGB(255, 45, 70, 184),
                weight: FontWeight.w700)),
        icon: Icon(
          Icons.remove_circle_outline_outlined,
          size: 30,
          color: (myInfo.isDark)
              ? const Color.fromARGB(255, 175, 171, 165)
              : const Color.fromARGB(255, 45, 70, 184),
        ),
        onPressed: () async {},
      ),
      TextButton.icon(
        label: Text('اضافة',
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
        onPressed: () {},
      ),
    ],
  );
}

void addToItem(
    {required String itemName,
    required bool fromStock,
    required int amount}) async {
  print('add to $itemName+$fromStock,$amount');
}

void removeFromItem(
    {required String itemName,
    required bool toStock,
    required int amount}) async {
  print('remove from $itemName+$toStock,$amount');
}
