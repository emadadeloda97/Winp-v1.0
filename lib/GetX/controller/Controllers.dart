import 'package:WINP/GetX/models/database_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../views/comp.dart';

class MyInfo extends GetxController {
  RxInt now = DateTime.now().hour.obs;
  bool get isDark => now.value > 15 ? true : false;

  RxList<dynamic> ItemList = [].obs;
  RxList ShopsNames = [].obs;
  RxList ShopsList = [].obs;

  RxList ItemsNames = [].obs;
  var SelectecItemsList = [].obs;

//////////////////////////////////// input Shop item list///////////////////////
////////////////////////////////////////////////////////////////////////////////
  RxString ItemSelectedName = ''.obs;
  RxBool fromStock = false.obs;
  void updateItemSelected(v) {
    ItemSelectedName.value = v;
  }

  void updateFromStockValue(v) {
    fromStock.value = v;
  }

  void addItemToSelectedList(itemName, amont, FromStock) {
    SelectecItemsList.add('$itemName|$FromStock|$amont');

    fromStock.value = false;
    ItemsNames.remove(itemName);
    ItemSelectedName.value = ItemsNames.first;
  }

  void resetShopItemList() async {
    ItemsNames.value = await DBItem.readAllItemName();
    ItemsNames.insert(0, '');
    ItemSelectedName.value = ItemsNames.first;
    fromStock.value = false;
    SelectecItemsList.clear();
  }

  void resetShopItemListAddNew() async {
    SelectecItemsList.clear();
  }
////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

  void updateItemList() async {
    ItemList.value = await DBItem.readAll();
  }

  void updateItemsNames() async {
    ItemsNames.value = await DBItem.readAllItemName();
    ItemsNames.insert(0, '');
    ItemSelectedName.value = ItemsNames.first;
  }

  void updateShopList() async {
    ShopsNames.value = await DBShopItemsList.readAllShopName();
    ShopsList.value = await DBShopItemsList.readAll();
  }

//////////////////////////////////////////////////////////////////////////////////////////
  RxBool sellMaksab = false.obs;
  void updateSeeMaksab() {
    sellMaksab.value = !sellMaksab.value;
  }

  void resetSeeMaksab() {
    sellMaksab.value = false;
  }
  ////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////
  RxBool isLoding = true.obs;
  void updateIsLoadin() {
    isLoding.value = !isLoding.value;
  }

  void resetIsLoadin() {
    isLoding.value = true;
  }
  /////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////
  ///////////////////remove dialog shop item check box ///////////////////////
  RxBool removeDialogShopItemCheckBoxValue = true.obs;
  void updateRemoveDialogShopItemCheckBoxValue() {
    removeDialogShopItemCheckBoxValue.value =
        !removeDialogShopItemCheckBoxValue.value;
  }
  //////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
/////////////////////Edit shop item screen ctrls/////////////////////////
  RxBool renameShop = false.obs;
  void updateRenameShop() {
    renameShop.value = !renameShop.value;
  }

/* Daily Controller */

  RxMap dailyRecord = {}.obs;
  Rx<TextEditingController> dateSelected = TextEditingController().obs;
  RxList isExpantedInputAmountScreen = [].obs;
  RxList isExpantedDailyRecord = [].obs;
  RxList itemShopList = [].obs;
  RxList selectedItemText = [].obs;

  void setDailyRecords() async {
    dailyRecord.value = await DBDailySell.readByDate();
    dateSelected.value.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // isExpanted.value = false;
    isExpantedInputAmountScreen.value =
        ShopsNames.map((element) => false).toList();
    isExpantedDailyRecord.value =
        dailyRecord.keys.toList().map((element) => false).toList();
    selectedItemText.value = ShopsNames.map((element) => '').toList();
  }

  void updateDateSelected(newDate) {
    String n = DateFormat('yyyy-MM-dd').format(newDate);
    dateSelected.value.text = n;
  }

  void updateIsExpantedDailyRecord(index, isbool) async {
    if (isbool) {
      isExpantedDailyRecord.value =
          dailyRecord.keys.toList().map((element) => false).toList();
    } else {
      isExpantedDailyRecord.value =
          dailyRecord.keys.toList().map((element) => false).toList();
      isExpantedDailyRecord[index] = true;
    }
  }

  void updateIsExpanted(index, shopName, isbool) async {
    if (isbool) {
      isExpantedInputAmountScreen.value =
          ShopsNames.map((element) => false).toList();
    } else {
      isExpantedInputAmountScreen.value =
          ShopsNames.map((element) => false).toList();
      isExpantedInputAmountScreen[index] = true;
      itemShopList.value = await DBShopItemsList.readByShop(shopName);
    }
  }

  updateSelectedItemText(String name, String amount, int index) {
    if (amount != '') {
      if (selectedItemText[index] == '') {
        selectedItemText[index] += name + ':' + amount;
      } else {
        selectedItemText[index] += "\n" + name + ':' + amount;
      }
    }
  }

  removeSelectedItemText(index) {
    selectedItemText[index] = '';
  }

/* */

//   // @override
//   // void onInit() async {
//   //   super.onInit();
//   //   // var x = await DBItem.readAllItemName();

//   //   // try {
//   //   //   isSelect.value = x.first;
//   //   // } catch (e) {}
//   // }

//   void setItemShopInfoByShop(String shop) async {
//     ItemShopInfoByShop.value = await DBShopItemsList.readByShop(shop);
//   }

//   void updateFromStock() {
//     fromStock.value = !fromStock.value;
//   }

//   void updataShopsNames() async {
//     var x = await DBShop.readAllNames();
//     ShopsNames.value = x;
//     print(x);
//   }

//   void updateItemsNames() async {
//     // var x = await DBItem.readAllItemName();
//     // try {
//     //   ItemsNames.value = x;
//     //   isSelect.value = x.first;
//     // } catch (e) {}
//     print('Item List updated');
//     ItemsNames.add({'item': 'aa'});
//   }

//   void itemShopListSwitch() {
//     if (ItemsNames.isEmpty) {
//       addItemShopListBool.value = false;
//     } else {
//       addItemShopListBool.value = !addItemShopListBool.value;
//     }
//   }

//   void setDropbox(Value) {
//     isSelect.value = Value;
//   }

//   void resetAll() {
//     isSelect.value = '';
//     ItemsNames.value = [];
//     ShopsNames.value = [];
//     ItemSelected.value = [];
//     ItemSelectedText.value = [];
//     fromStock.value = false;
//     ItemShopInfoByShop.value = [];
//   }

//   void updateItemList() {
//     ItemsNames.value = [
//       {'aaaa': 'aaaa'}
//     ];
//   }

//   void updateShopList() async {
  //   ShopList.value = await DBShop.readAll();
  // }
}

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'المبيع اليومي', icon: Icon(Icons.store)),
    Tab(text: 'السلع', icon: Icon(Icons.category_rounded)),
    Tab(text: 'اماكن البيع', icon: Icon(Icons.list_alt_rounded)),
  ];

  RxInt currentIndex = 0.obs;

  late TabController controller;

  @override
  void onInit() {
    super.onInit();

    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();

    super.onClose();
  }

  void changeCurrentIndex(int x) {
    currentIndex.value = x;
  }

  Text AppBarTitleChanger(int hour) {
    // MyInfo().updateItemsNames();
    if (currentIndex.value == 0) {
      return Text('المبيع اليومي',
          style: ArabicStyle(
              color: const Color.fromARGB(255, 239, 239, 241),
              fontSize: 35,
              weight: FontWeight.w700));
    } else if (currentIndex.value == 1) {
      return Text('الحاجات الي بتبعها',
          style: ArabicStyle(
              color: const Color.fromARGB(255, 239, 239, 241),
              fontSize: 35,
              weight: FontWeight.w700));
    } else {
      return Text('اماكن البيع',
          style: ArabicStyle(
              color: const Color.fromARGB(255, 239, 239, 241),
              fontSize: 35,
              weight: FontWeight.w700));
    }
  }
}
