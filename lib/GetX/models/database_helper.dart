// ignore_for_file: prefer_const_declarations

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'database_entity.dart';

class DatabaseHelper {
  static final _dbName = 'MyDatabase.db';
  static final _dbVersion = 1;
  static final DatabaseHelper instace = DatabaseHelper._privetConstractor();
  DatabaseHelper._privetConstractor();

  static Database? _database;
  Future<Database> get databese async {
//when finish
    print("database");
    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
    // _database = await openDatabase('assets/db.db');
    // return _database!;
  }

  _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }
  // ${ItemFiled.ItemId}	INTEGER NOT NULL UNIQUE,

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "${ItemFiled.TableName}" (

	    "${ItemFiled.ItemName}"	TEXT NOT NULL UNIQUE,
      "${ItemFiled.StockNum}" INTEGER,
	    "${ItemFiled.StockPrice}"	NUMERIC NOT NULL,
	    "${ItemFiled.SellPrice}"	NUMERIC NOT NULL,
	    PRIMARY KEY("${ItemFiled.ItemName}")
      )''');
    await db.execute('''
      CREATE TABLE "${ShopItemsListFiled.TableName}"(
      "${ShopItemsListFiled.ItemShop}"	TEXT NOT NULL UNIQUE,
	    "${ShopItemsListFiled.ShopName}"	TEXT NOT NULL,
	    "${ShopItemsListFiled.ItemName}"	TEXT,
	    "${ShopItemsListFiled.Remind}"	INTEGER DEFAULT 0,
	    "${ShopItemsListFiled.Selled}"	INTEGER  DEFAULT 0,
	    PRIMARY KEY("${ShopItemsListFiled.ShopName}","${ShopItemsListFiled.ItemName}","${ShopItemsListFiled.ItemName}"),
	    FOREIGN KEY("${ShopItemsListFiled.ItemName}") REFERENCES "${ItemFiled.TableName}"("${ItemFiled.ItemName}")
      )''');
    await db.execute('''
      CREATE TABLE ${DailySellFiled.TableName} (
      ${DailySellFiled.Date}	TEXT NOT NULL,
      ${DailySellFiled.ItemName}	TEXT NOT NULL ,
      ${DailySellFiled.ShopName}	TEXT NOT NULL ,
      ${DailySellFiled.Selled}	INTEGER,
      PRIMARY KEY(${DailySellFiled.Date},${DailySellFiled.ItemName},${DailySellFiled.ShopName}),
      FOREIGN KEY(${DailySellFiled.ItemName}) REFERENCES ${ItemFiled.TableName}(${ItemFiled.ItemName})
      )''');
  }

  Future close() async {
    final db = await instace.databese;
    db.close();
  }

  Future<int> deleteDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    databaseFactory.deleteDatabase(path);
    DatabaseHelper._privetConstractor();
    return 1;
  }
}
