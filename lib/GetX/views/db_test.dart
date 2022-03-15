// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oda_tables/GetX/models/database_entity.dart';
import 'package:oda_tables/GetX/models/database_helper.dart';
import 'package:restart_app/restart_app.dart';

class DB_test extends StatefulWidget {
  const DB_test({Key? key}) : super(key: key);
  static String routeName = '/test';

  @override
  State<DB_test> createState() => _DB_testState();
}

class _DB_testState extends State<DB_test> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  final l = [
    ['i1', 'Item1'],
    ['i2', 'Item2']
  ];
  @override
  Widget build(BuildContext context) {
    print("TestEnter");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data base Test'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    print(await DBItem.readAll());
                  },
                  child: const Text("read items")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.insert(const DBItem(
                        ItemName: 'Item2',
                        StockNum: 500,
                        StockPrice: 0,
                        SellPrice: 0)));
                  },
                  child: const Text("add item")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.deleteAll());
                  },
                  child: const Text("drop item")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.deleteRow(
                      itemNameToDelete: 'i1',
                    ));
                  },
                  child: const Text("update item")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.deleteRow(itemNameToDelete: 'Item1'));
                  },
                  child: const Text("delete item")),
              const Divider(),
              TextButton(
                  onPressed: () async {
                    print(await DBShopItemsList.readAll());
                  },
                  child: const Text("read ShopItemList")),
              TextButton(
                  onPressed: () async {
                    print(await DBShopItemsList.insertFromStock(DBShopItemsList(
                      ItemName: 'Item2',
                      ShopName: "s3",
                      Remind: 250,
                    )));
                  },
                  child: const Text("add ShopItemList")),
              TextButton(
                  onPressed: () async {
                    // print(await DBShopItemsList.updateRemind('i2',
                    //     valueToAdd: 11));
                    // print(await DBShopItemsList.deleteAndMoveToStock('Item2'));
                  },
                  child: const Text("Seller ShopItemList")),
              TextButton(
                  onPressed: () async {
                    print(await DBShopItemsList.deleteAll());
                  },
                  child: const Text("drop ShopItemList")),
              const Divider(),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.readAll());
                  },
                  child: const Text("read daily")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.insert(const DBItem(
                        ItemName: 'Item1',
                        StockNum: 0,
                        StockPrice: 0,
                        SellPrice: 0)));
                  },
                  child: const Text("add daily")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.deleteAll());
                  },
                  child: const Text("drop daily")),
              TextButton(
                  onPressed: () async {
                    print(await DBItem.deleteRow(itemNameToDelete: 'Item1'));
                  },
                  child: const Text("delete daily")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await DBItem.deleteAll();
          // await DBShopItemsList.deleteAll();
          final db = DatabaseHelper.instace;
          await db.deleteDatabase();
        },
      ),
    );
  }
}
