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
            children: [],
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
