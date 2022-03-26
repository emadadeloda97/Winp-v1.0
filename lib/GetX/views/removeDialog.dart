// ignore_for_file: file_names, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:WINP/GetX/controller/Controllers.dart';
import 'package:WINP/GetX/models/database_entity.dart';
import 'package:WINP/GetX/views/comp.dart';

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
                              TextToast.show("تم الحذف بنجاح $element",
                                  bgc: Colors.green, duration: 3);
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
Future<dynamic> RemoveShopDialog(data) {
  final MyInfo myInfo = Get.find(tag: 'MyInfo');
  // myInfo.updataShopsNames();
  return Get.defaultDialog(
    title: "حذف مكان",
    titleStyle: ArabicStyle(fontSize: 35),
    content: Directionality(
        textDirection: TextDirection.rtl,
        child: RemoveShopWidget(
          shpoList: data,
        )),
  );
}

class RemoveShopWidget extends StatelessWidget {
  const RemoveShopWidget({Key? key, required List this.shpoList})
      : super(key: key);
  final List shpoList;

  @override
  Widget build(BuildContext context) {
    // final DBCont dbCont = Get.find(tag: 'database');
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return SizedBox(
      width: 500,
      child: Column(
        children: shpoList
            .map(
              (e) => Card(
                  child: Container(
                decoration: containerDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      e,
                      style: ArabicStyle(fontSize: 30),
                    ),
                    IconButton(
                        onPressed: () async {
                          Get.defaultDialog(
                              title: " : هتعمل ايه في البضاعة ",
                              titleStyle: ArabicStyle(),
                              content: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          value: myInfo
                                              .removeDialogShopItemCheckBoxValue
                                              .value,
                                          onChanged: (b) => myInfo
                                              .updateRemoveDialogShopItemCheckBoxValue(),
                                        ),
                                      ),
                                      Text(
                                        "رجع علي المخزن",
                                        style: ArabicStyle(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          value: !myInfo
                                              .removeDialogShopItemCheckBoxValue
                                              .value,
                                          onChanged: (b) => myInfo
                                              .updateRemoveDialogShopItemCheckBoxValue(),
                                        ),
                                      ),
                                      Text(
                                        "شيلهم خالص",
                                        style: ArabicStyle(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              textCancel: "الغاء",
                              textConfirm: "تم",
                              onConfirm: () async {
                                if (myInfo
                                    .removeDialogShopItemCheckBoxValue.value) {
                                  //// go to stock
                                  print('form Stock');
                                  var Items =
                                      await DBShopItemsList.readByShop(e);
                                  for (var item in Items) {
                                    print(item['ItemName']);
                                    await DBShopItemsList.deleteAndMoveToStock(
                                        itemShop:
                                            '${item['ItemName']}_${item['ShopName']}',
                                        itemName: '${item['ItemName']}');
                                    TextToast.show(
                                        "تم حذف ${item['ItemName']} واضافة  ${item['Remind']} الي المخزن",
                                        duration: 3);
                                  }
                                  await DBShopItemsList.deleteShop(
                                      shopNameToDelete: e);
                                  Get.back();
                                  myInfo.updateShopList();
                                } else {
                                  /// remove
                                  print('remove');
                                  await DBShopItemsList.deleteShop(
                                      shopNameToDelete: e);
                                  TextToast.show("تم حذف $eاضافة ",
                                      duration: 3);
                                  Get.back();
                                  myInfo.updateShopList();
                                }
                              });
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
            .toList(),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
