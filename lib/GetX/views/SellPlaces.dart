// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/views/EditDialog.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:oda_tables/GetX/views/comp.dart';
import 'package:oda_tables/GetX/views/removeDialog.dart';
import '../controller/Controllers.dart';
import 'inputDialog.dart';
import 'moreInfoScreen.dart';

final MyInfo myInfo = Get.find(tag: 'MyInfo');

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class SellPlaces extends StatelessWidget {
  const SellPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myInfo.updateShopList();
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
                // myInfo.updateShopList();
                if (myInfo.ShopsNames.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      const Icon(
                        Icons.shop,
                        size: 45,
                      ),
                      Text(
                        'اعمل اضافة من تحت',
                        style: ArabicStyle(fontSize: 40),
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        size: 80,
                      ),
                    ],
                  ));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: myInfo.ShopsNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SmallShopCard(
                            shopName: myInfo.ShopsNames[index]);
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
                onPressed: () async {
                  print(myInfo.ShopsNames);
                  RemoveShopDialog(myInfo.ShopsNames);
                },
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
                onPressed: () {
                  Get.to(() => InputShopScreen());
                  myInfo.resetShopItemList();
                },
              ),
            ],
          ),
        ));
  }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class SmallShopCard extends StatelessWidget {
  final String shopName;

  const SmallShopCard({Key? key, required this.shopName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    return Card(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: containerDecoration(),
      child: Column(
        children: [
          Text(
            shopName,
            style: ArabicStyle(fontSize: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    var list = await DBShopItemsList.readByShop(shopName);
                    var newData =
                        await DBShopItemsList.joinShopItemListSellPrice(
                            "${list.first['ShopName']}");

                    Get.to(() =>
                        EditShopItemListScreen(shopName: shopName, data: list));
                  },
                  child: Text(
                    'تعديل',
                    style: ArabicStyle(),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    var list = await DBShopItemsList.readByShop(shopName);
                    var newData =
                        await DBShopItemsList.joinShopItemListSellPrice(
                            "${list.first['ShopName']}");
                    myInfo.resetSeeMaksab();

                    Get.to(() => MoreInfoShopItemList(
                        data: newData, shopName: shopName));
                  },
                  child: Text(
                    'معلومات اكنر',
                    style: ArabicStyle(),
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
///
///
///

