// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:WINP/GetX/models/database_entity.dart';

import 'package:WINP/GetX/views/SellPlaces.dart';
import 'package:WINP/GetX/views/comp.dart';

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

class EditShopItemListScreen extends StatelessWidget {
  final String shopName;
  final List data;

  const EditShopItemListScreen(
      {Key? key, required this.shopName, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfo myInfo = Get.find(tag: 'MyInfo');
    final TextEditingController shopNameCtrl = TextEditingController();
    List actions = [];
    List actionsText = [];
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
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(227, 242, 253, 1),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 33, 149, 243),
                                  width: 2),
                              borderRadius: BorderRadius.circular(15))),
                      label: Text("حذف", style: ArabicStyle(fontSize: 25)),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'شيل',
                  items: remove,
                  data: {},
                  actions: actions,
                  actionsList: actionsText,
                )),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'اضافة',
                  items: add,
                  data: {},
                  actions: actions,
                  actionsList: actionsText,
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
                  actions: actions,
                  actionsText: actionsText,
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(
          myInfo: myInfo, child: BottomBarRow(actions, actionsText)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddNewItemToExistShop(data: data));
        },
        label: Text('اضافة سلعة',
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
        backgroundColor: Color.fromRGBO(93, 100, 150, 1),
      ),
    );
  }

  void addToItem({required Map args}) async {
    print(
        'add to ${args['itemName']}+to stock${args['toStock']},${args['amount']}');
    int r = await DBShopItemsList.addToRemind(
        item: args['itemName'],
        fromStock: args['fromStock'],
        valueToAdd: args['amount'],
        newValue: args['data']['Remind'] + args['amount']);
    if (r == 1) {
      TextToast.show('done');
    } else {
      TextToast.show('faild');
    }
    myInfo.updateShopList();
  }

  void removeFromItem({
    required Map args,
  }) async {
    print(
        'add to ${args['itemName']}+to stock${args['toStock']},${args['amount']}');
    int r = await DBShopItemsList.removeFromRemind(
        item: args['itemName'],
        toStock: args['toStock'],
        valueToAdd: args['amount'],
        newValue: args['data']['Remind'] - args['amount']);
    if (r == 1) {
      TextToast.show('done');
    } else {
      TextToast.show('faild');
    }
    myInfo.updateShopList();
  }

  Row BottomBarRow(actions, List actionsText) {
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
          label: Text('حفظ التعديلات',
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
          onPressed: () {
            Get.defaultDialog(
                content: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: actionsText
                          .map((e) => Text(
                                e,
                                style: ArabicStyle(fontSize: 18),
                              ))
                          .toList(),
                    )),
                onConfirm: () async {
                  for (var item in actions) {
                    switch (item[0]) {
                      case 'removeFromItem':
                        removeFromItem(args: item[1]);
                        break;
                      case 'addToItem':
                        addToItem(args: item[1]);
                        break;
                    }
                  }
                  Get.back();
                  Get.back();
                });
          },
        ),
      ],
    );
  }
}

class EditShopItemCard extends StatelessWidget {
  final Map data;
  List actions;
  List actionsText;
  EditShopItemCard(
      {Key? key,
      required this.data,
      required this.actions,
      required this.actionsText})
      : super(key: key);

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
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(227, 242, 253, 1),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 33, 149, 243),
                                  width: 2),
                              borderRadius: BorderRadius.circular(15))),
                      label: Text("حذف", style: ArabicStyle(fontSize: 25)),
                      onPressed: () {
                        RemoveItemShopDialog(data);
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'شيل',
                  items: remove,
                  data: data,
                  actions: actions,
                  actionsList: actionsText,
                )),
                Expanded(
                    child: EditShopItemDropDown(
                  hint: 'اضافة',
                  items: add,
                  data: data,
                  actions: actions,
                  actionsList: actionsText,
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
  List actions;
  List actionsList;
  EditShopItemDropDown(
      {Key? key,
      required this.items,
      required this.hint,
      required this.data,
      required this.actions,
      required this.actionsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Row(
              children: [
                Text(
                  hint,
                  style: ArabicStyle(),
                ),
                Icon(
                  hint == 'شيل' ? Icons.remove : Icons.add,
                )
              ],
            ),
            alignment: AlignmentDirectional.center,
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
                    ShopItemDropDownButtonFunction(
                        data, TextValues.removeToSrock);
                  }
                  break;
                case 'شيل خالص':
                  {
                    ShopItemDropDownButtonFunction(
                        data, TextValues.removeToNothing);
                  }
                  break;
                case 'من برا':
                  {
                    ShopItemDropDownButtonFunction(
                        data, TextValues.addFromNothing);
                  }
                  break;
                case 'من المخزن':
                  {
                    ShopItemDropDownButtonFunction(
                        data, TextValues.addFromStock);
                  }
                  break;
              }
            },
            iconSize: 0,
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                width: 2,
                color: const Color.fromARGB(255, 33, 149, 243),
              ),
              color: const Color.fromRGBO(227, 242, 253, 1),
            ),
            dropdownWidth: 200,
            dropdownDecoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 33, 149, 243),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }

  void ShopItemDropDownButtonFunction(Map data, dynamic value) {
    final TextEditingController amount = TextEditingController();
    // myInfo.allAmount.value ? amount.text = data['Remind'] : amount.text = '';
    Get.defaultDialog(
        middleText: '$data',
        title: ' ${value[0]} \n${data['ItemName']}',
        titleStyle: ArabicStyle(),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Text(
                '${value[1]} ',
                style: ArabicStyle(),
              ),
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.number,
                controller: amount,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )),
            ],
          ),
        ),
        textConfirm: 'حفظ',
        textCancel: 'الغاء',
        onConfirm: () {
          print(data);
          int reqAmount = 0;
          if (amount.text != '') {
            if (value == TextValues.addFromNothing ||
                value == TextValues.addFromStock) {
              actions.add([
                'addToItem',
                {
                  'itemName': data['ItemName'],
                  'fromStock': value[2],
                  'amount': int.parse(amount.text),
                  'data': data
                }
              ]);
              actionsList.add(
                  'اضافة ${amount.text} الي ${data['ItemName']} من ${value[2] ? 'المخزن' : 'برا'}');
            } else {
              actions.add([
                'removeFromItem',
                {
                  'itemName': data['ItemName'],
                  'toStock': value[2],
                  'amount': int.parse(amount.text),
                  'data': data
                }
              ]);
              actionsList.add(
                  'حذف ${amount.text} من ${data['ItemName']} ${value[2] ? 'للمخزن' : 'لبرا'}');
            }
            TextToast.show('${value[0]}');

            Get.back();
          }
        });
  }
}

class TextValues {
  static List removeToSrock = [
    'شيل للمخزن',
    'هتشيل قد ايه : ',
    true,
  ];
  static List removeToNothing = [
    'شيل خالص',
    'هتشيل قد ايه : ',
    false,
  ];
  static List addFromStock = [
    'اضافة من المخزن',
    'هضيف قد ايه : ',
    true,
  ];
  static List addFromNothing = [
    'اضافة من برا',
    'هضيف قد ايه : ',
    false,
  ];
}

RemoveItemShopDialog(data) {
  Get.defaultDialog(
      title: " : هتعمل ايه في البضاعة ",
      titleStyle: ArabicStyle(),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Checkbox(
                  value: myInfo.removeDialogShopItemCheckBoxValue.value,
                  onChanged: (b) =>
                      myInfo.updateRemoveDialogShopItemCheckBoxValue(),
                ),
              ),
              Text(
                "رجع علي المخزن",
                style: ArabicStyle(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Checkbox(
                  value: !myInfo.removeDialogShopItemCheckBoxValue.value,
                  onChanged: (b) =>
                      myInfo.updateRemoveDialogShopItemCheckBoxValue(),
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
        if (myInfo.removeDialogShopItemCheckBoxValue.value) {
          //// go to stock
          print('form Stock');
          var Items = await DBShopItemsList.read(data['ItemShop']);

          print(Items['ItemName']);
          await DBShopItemsList.deleteAndMoveToStock(
              itemShop: data['ItemShop'], itemName: data['ItemName']);
          TextToast.show(
              "تم حذف ${data['ItemName']} واضافة  ${data['Remind']} الي المخزن",
              duration: 3);

          await DBShopItemsList.deleteItemShop(
              itemShopNameToDelete: data['ItemShop']);
          Get.back();
          myInfo.updateShopList();
        } else {
          /// remove
          print('remove');
          await DBShopItemsList.deleteItemShop(
              itemShopNameToDelete: data['ItemShop']);
          TextToast.show("تم حذف $data['ShopName']اضافة ", duration: 3);
          Get.back();
          myInfo.updateShopList();
        }
      });
}

class AddNewItemToExistShop extends StatelessWidget {
  const AddNewItemToExistShop({Key? key, required this.data}) : super(key: key);
  final List data;

  @override
  Widget build(BuildContext context) {
    myInfo.resetShopItemListAddNew();
    final amont = TextEditingController();
    var newItemList = myInfo.ItemsNames;
    print(newItemList);
    for (var item in data) {
      newItemList.remove(item['ItemName']);
    }
    print(newItemList);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(
          myInfo: myInfo,
          title: Text('اضافة سلعة'),
        ),
        body: Column(
          children: [
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
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black),
                              items: newItemList
                                  .map((element) => DropdownMenuItem(
                                        child: SizedBox(
                                          width: 100,
                                          child: Text(element,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        value: element,
                                      ))
                                  .toList(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      '${element.toString().split('|')[0]} : ${element.toString().split('|')[2]} '),
                                  IconButton(
                                      onPressed: (() {
                                        myInfo.SelectecItemsList.remove(
                                            element);
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
          ],
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
                    if (myInfo.SelectecItemsList.isNotEmpty) {
                      for (var item in myInfo.SelectecItemsList) {
                        print(item);
                        if (item.toString().split('|')[1] == 'true') {
                          String r = await DBShopItemsList.insertFromStock(
                              DBShopItemsList(
                                  ItemName: item.toString().split('|')[0],
                                  ShopName: data.first['ShopName'],
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
                              ShopName: data.first['ShopName'],
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
                    myInfo.updateShopList();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
