// ignore_for_file: file_names, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/controller/Controllers.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:oda_tables/GetX/views/comp.dart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
Future<dynamic> RemoveItemDialog() {
  final MyInfo myInfo = Get.find(tag: 'MyInfo');
  myInfo.updateItemsNames();
  return Get.defaultDialog(
    title: "حذف صنف",
    titleStyle: ArabicStyle(fontSize: 35),
    content: const Directionality(
        textDirection: TextDirection.rtl, child: RemoveItemWidget()),
  );
}

class RemoveItemWidget extends StatelessWidget {
  const RemoveItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final DBCont dbCont = Get.find(tag: 'database');
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return SizedBox(
      width: 500,
      child: Obx(() => Column(
            children: [
              ...myInfo.ItemsNames.map(
                (element) => Card(
                    child: Container(
                  decoration: containerDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        element,
                        style: ArabicStyle(fontSize: 30),
                      ),
                      IconButton(
                          onPressed: () async {
                            try {
                              await DBItem.deleteRow(itemNameToDelete: element);
                              Get.back();
                              myInfo.updateItemList();
                              myInfo.updateItemsNames();
                              Get.snackbar("تم الحذف", 'بنجاح');
                            } catch (e) {}
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline_outlined,
                            size: 30,
                            color: Colors.red,
                          ))
                    ],
                  ),
                )),
              )
            ],
          )),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
Future<dynamic> RemoveShopDialog() {
  final MyInfo myInfo = Get.find(tag: 'MyInfo');
  // myInfo.updataShopsNames();
  return Get.defaultDialog(
    title: "حذف مكان",
    titleStyle: ArabicStyle(fontSize: 35),
    content: const Directionality(
        textDirection: TextDirection.rtl, child: RemoveShopWidget()),
  );
}

class RemoveShopWidget extends StatelessWidget {
  const RemoveShopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final DBCont dbCont = Get.find(tag: 'database');
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return SizedBox(
      width: 500,
      child: Obx(() => Column(
            children: [
              // ...myInfo.ShopsNames.map(
              //   (element) => Card(
              //       child: Container(
              //     decoration: containerDecoration(),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Text(
              //           element,
              //           style: ArabicStyle(fontSize: 30),
              //         ),
              //         IconButton(
              //             onPressed: () async {
              //               try {
              //                 await DBShop.delete(element);
              //                 // await DBShopItemsList.deleteByShop(element);
              //                 Get.back();
              //                 Get.snackbar("تم الحذف", 'بنجاح');
              //                 // myInfo.resetAll();
              //                 // myInfo.updateShopList();
              //               } catch (e) {}
              //             },
              //             icon: const Icon(
              //               Icons.remove_circle_outline_outlined,
              //               size: 30,
              //               color: Colors.red,
              //             ))
              //       ],
              //     ),
              //   )),
              // )
            ],
          )),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////