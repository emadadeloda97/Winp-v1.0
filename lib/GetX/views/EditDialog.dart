// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_local_variable

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

// class MoreInfoShopItemList extends StatelessWidget {
//   final ShopNameCtrl = TextEditingController();

//   final List data;
//   final String shopName;

//   // final DBCont dbCont = Get.find(tag: 'database');

//   MoreInfoShopItemList({Key? key, required this.data, required this.shopName})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ShopNameCtrl.text = shopName;

//     final amont = TextEditingController();

//     final MyInfo myInfo = Get.find(tag: 'MyInfo');

//     return Scaffold(
//         backgroundColor: (myInfo.isDark)
//             ? const Color.fromARGB(255, 175, 171, 165)
//             : const Color.fromARGB(255, 255, 255, 255),
//         appBar: MyAppBar(
//           myInfo: myInfo,
//           title: Text(
//             'التعديل قائمة الاصناف',
//             style: ArabicStyle(color: Colors.white),
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               margin: const EdgeInsets.all(8),
//               decoration: containerDecoration(),
//               child: Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Row(
//                   children: [
//                     Text(
//                       'أسم المكان : ',
//                       style: ArabicStyle(),
//                     ),
//                     Expanded(
//                         child: TextField(
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25))),
//                       textAlign: TextAlign.center,
//                       controller: ShopNameCtrl,
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//             Text(
//               " قائمة السلع : ",
//               style: ArabicStyle(),
//               textDirection: TextDirection.rtl,
//             ),
//             const Divider(
//               color: Colors.black,
//               endIndent: 25,
//               indent: 25,
//               thickness: 2,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ItemList_ShopList_Card(data: data[index]);
//                 },
//               ),
//             ),
//           ],
//         ));
//   }
// }

// // ignore: camel_case_types
// class ItemList_ShopList_Card extends StatelessWidget {
//   const ItemList_ShopList_Card({
//     Key? key,
//     required this.data,
//   }) : super(key: key);

//   final Map data;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(8),
//         decoration: containerDecoration(),
//         child: Column(
//           children: [
//             Text(
//               '${data["ItemName"]}',
//               style: ArabicStyle(),
//             ),
//             Directionality(
//               textDirection: TextDirection.rtl,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         "الباقي : ",
//                         style: ArabicStyle(),
//                       ),
//                       Text('${data['Remind']}')
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "المباع : ",
//                         style: ArabicStyle(),
//                       ),
//                       Text('${data['Selled']}')
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "المكسب : ",
//                         style: ArabicStyle(),
//                       ),
//                       Obx(
//                         () => InkWell(
//                           onTap: (() {
//                             myInfo.updateSeeMaksab();
//                           }),
//                           child: Container(
//                             child: myInfo.sellMaksab.value
//                                 ? Text('${data['Selled'] * data['SellPrice']}')
//                                 : Icon(Icons.hide_image_outlined),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
