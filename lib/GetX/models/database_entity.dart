// ignore_for_file: constant_identifier_names, non_constant_identifier_names, avoid_print

import 'package:WINP/GetX/models/database_helper.dart';
import 'package:sqflite/sqflite.dart';

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class ItemFiled {
  static final List<String> values = [
    StockNum,
    ItemName,
    StockPrice,
    SellPrice
  ];
  static final List<List<String>> valuesArabic = [
    ["اسم الصنف", ''],
    ["سعر الجملة", ''],
    ["سعر البيع", '']
  ];
  static const String ItemName = 'ItemName';
  static const String StockNum = 'StockNum';
  static const String StockPrice = 'StockPrice';
  static const String SellPrice = 'SellPrice';
  static const String TableName = 'ItemTable';
}

class DBItem {
  final String ItemName;
  final int StockNum;
  final double StockPrice;
  final double SellPrice;

  const DBItem({
    required this.ItemName,
    required this.StockNum,
    required this.StockPrice,
    required this.SellPrice,
  });

  Map<String, Object?> toJSON() => {
        // ItemFiled.ItemId: ItemId,
        ItemFiled.ItemName: ItemName,
        ItemFiled.StockNum: StockNum,
        ItemFiled.StockPrice: StockPrice,
        ItemFiled.SellPrice: SellPrice,
      };

  static Future<int> insert(DBItem row) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.insert(ItemFiled.TableName, row.toJSON());
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Map> read(String itemName) async {
    final db = await DatabaseHelper.instace.databese;
    final map = await db.query(ItemFiled.TableName,
        columns: ItemFiled.values,
        where: "ItemName = ?",
        whereArgs: [itemName]);
    if (map.isNotEmpty) {
      return map.first;
    } else {
      throw Exception('Itme $itemName not found');
    }
  }

  static Future<List<Map<String, Object?>>> readAll() async {
    final db = await DatabaseHelper.instace.databese;
    try {
      final map = await db.query(
        ItemFiled.TableName,
      );

      return map;
    } catch (e) {
      return [throw Exception(e)];
    }
  }

  static Future<List<String>> readAllItemName() async {
    final db = await DatabaseHelper.instace.databese;
    final List<String> ItemNames = [];
    try {
      final map = await db.query(
        ItemFiled.TableName,
      );

      for (var item in map) {
        ItemNames.add(item['ItemName'].toString());
      }
      return ItemNames;
    } catch (e) {
      return ItemNames;
    }
  }

  static Future<int> deleteAll() async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.delete(ItemFiled.TableName);
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<int> update(Map<String, dynamic> value,
      {required String itemName}) async {
    try {
      final db = await DatabaseHelper.instace.databese;
      await db.update(
        ItemFiled.TableName,
        value,
        where: '${ItemFiled.ItemName} = ?',
        whereArgs: [itemName],
      );
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<int> deleteRow({required String itemNameToDelete}) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.delete(ItemFiled.TableName,
          where: '${ItemFiled.ItemName} = ?', whereArgs: [itemNameToDelete]);
      await DBShopItemsList.deleteItem(itemNameToDelete: itemNameToDelete);
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future close() async {
    final db = await DatabaseHelper.instace.databese;
    db.close();
    print('database colsed');
  }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

class DailySellFiled {
  static final List<String> values = [
    Date,
    ItemName,
    ShopName,
    Selled,
  ];
  static const String Date = 'Date';
  static const String ItemName = 'ItemName';
  static const String ShopName = 'ShopName';
  static const String Selled = 'Selled';
  static const String TableName = 'DailySellTable';
}

class DBDailySell {
  final String Date;
  final String ItemName;
  final String ShopName;
  final int Selld;

  const DBDailySell({
    required this.Date,
    required this.ItemName,
    required this.ShopName,
    required this.Selld,
  });

  Map<String, Object?> toJSON() => {
        DailySellFiled.Date: Date,
        DailySellFiled.ItemName: ItemName,
        DailySellFiled.ShopName: ShopName,
        DailySellFiled.Selled: Selld,
      };

  static Future<List<Map>> readAll() async {
    final db = await DatabaseHelper.instace.databese;
    final list = await db.query(
      DailySellFiled.TableName,
    );
    return list;
  }

  static Future<void> deleteAll() async {
    final db = await DatabaseHelper.instace.databese;
    await db.delete(
      DailySellFiled.TableName,
    );
  }

  static Future<int> insertRow(DBDailySell data) async {
    final db = await DatabaseHelper.instace.databese;
    var old = await DBShopItemsList.read('${data.ItemName}_${data.ShopName}');
    try {
      if (old['Remind'] >= data.Selld) {
        await db.update(
            ShopItemsListFiled.TableName,
            {
              'Remind': old['Remind'] - data.Selld,
              'Selled': old['Selled'] + data.Selld
            },
            where: 'ItemShop = ?',
            whereArgs: ['${data.ItemName}_${data.ShopName}']);
        await db.insert(DailySellFiled.TableName, data.toJSON());
        return 1;
      } else {
        print('LessThan');
        return 2;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static readRow({required date, required item, required shop}) async {
    final db = await DatabaseHelper.instace.databese;
    List<Map<String, Object?>> oldD = await db.rawQuery('''
      SELECT * FROM ${DailySellFiled.TableName} WHERE (Date='$date' AND ItemName='$item' AND ShopName='$shop')
''');
    return oldD.first;
  }

  static deleteRow({required date, required item, required shop}) async {
    final db = await DatabaseHelper.instace.databese;

    await db.rawDelete(
        '''DELETE FROM ${DailySellFiled.TableName} WHERE (Date='$date' AND ItemName='$item' AND ShopName='$shop')''');
  }

  static rollback(
      {required String date,
      required String item,
      required String shop}) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      var oldD = await readRow(date: date, item: item, shop: shop);
      await deleteRow(date: date, item: item, shop: shop);
      var old = await DBShopItemsList.read('${item}_$shop');
      print(' r = ${old['Remind']}    ${oldD['Selled']}');
      print('s = ${old['Selled']}');
      await db.update(
          ShopItemsListFiled.TableName,
          {
            'Remind': old['Remind'] + oldD['Selled'],
            'Selled': old['Selled'] - oldD['Selled']
          },
          where: 'ItemShop = ?',
          whereArgs: ['${item}_$shop']);
    } catch (e) {
      print(e);
    }
  }

  static readByDate({date}) async {
    final db = await DatabaseHelper.instace.databese;
    var l = await readAll();
    Map r = {};
    for (var item in l) {
      var date = item['Date'];
      var x = await db.query(DailySellFiled.TableName,
          where: 'Date = ?', whereArgs: [date]);
      r[date] = x;
    }

    return r;
  }
}

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class ShopItemsListFiled {
  static final List<String> values = [
    ItemShop,
    ItemName,
    ShopName,
    Remind,
    Selled,
  ];
  static const String ItemShop = 'ItemShop';
  static const String ItemName = ItemFiled.ItemName;
  static const String ShopName = 'ShopName';
  static const String Remind = 'Remind';
  static const String Selled = 'Selled';
  static const String TableName = 'ShopItemsListTable';
}

class DBShopItemsList {
  final String ItemName;
  final String ShopName;
  final String? ItemShop;
  final int Remind;
  final int? Selld;

  DBShopItemsList({
    this.ItemShop,
    required this.ItemName,
    required this.ShopName,
    required this.Remind,
    this.Selld,
  });

  Map<String, Object?> toJSON() => {
        ShopItemsListFiled.ItemShop: (ItemName + '_' + ShopName),
        ShopItemsListFiled.ShopName: ShopName,
        ShopItemsListFiled.ItemName: ItemName,
        ShopItemsListFiled.Selled: Selld ?? 0,
        ShopItemsListFiled.Remind: Remind,
      };

  static Future<String> insertFromStock(DBShopItemsList row) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      Map StockRow = await DBItem.read(row.ItemName);
      int oldStockNum = StockRow[ItemFiled.StockNum];
      print(oldStockNum);
      int newVale = oldStockNum - row.Remind;
      if (newVale < 0) {
        return 'LESS Stock';
      } else {
        await db.insert(ShopItemsListFiled.TableName, row.toJSON());
        await DBItem.update({ItemFiled.StockNum: newVale},
            itemName: row.ItemName);
      }

      return "Done";
    } catch (e) {
      print(e);
      return "Error";
    }
  }

  static Future<int> insert(DBShopItemsList row) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.insert(ShopItemsListFiled.TableName, row.toJSON());
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<Map> read(String ItemShop) async {
    final db = await DatabaseHelper.instace.databese;
    final map = await db.query(ShopItemsListFiled.TableName,
        columns: ShopItemsListFiled.values,
        where: "${ShopItemsListFiled.ItemShop} = ?",
        whereArgs: [ItemShop]);
    if (map.isNotEmpty) {
      return map.first;
    } else {
      return {"error": "eroerr"};
    }
  }

  static Future<int> update(Map<String, dynamic> value,
      {required String itemName}) async {
    try {
      final db = await DatabaseHelper.instace.databese;
      await db.update(
        ShopItemsListFiled.TableName,
        value,
        where: '${ShopItemsListFiled.ItemName} = ?',
        whereArgs: [itemName],
      );
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Map<String, Object?>>> readByShop(String shop) async {
    final db = await DatabaseHelper.instace.databese;
    final map = await db.rawQuery(
        'SELECT * FROM ${ShopItemsListFiled.TableName} WHERE ${ShopItemsListFiled.ShopName}== "$shop"');

    return map;
  }

  static joinShopItemListSellPrice(String shop) async {
    final db = await DatabaseHelper.instace.databese;
    var lll = [];

    ///
    List l = await db.rawQuery('''
SELECT ${ShopItemsListFiled.TableName}.${ItemFiled.ItemName},${ShopItemsListFiled.TableName}.${ShopItemsListFiled.ShopName}, ${ShopItemsListFiled.TableName}.${ShopItemsListFiled.Remind},${ShopItemsListFiled.TableName}.${ShopItemsListFiled.Selled},${ItemFiled.TableName}.${ItemFiled.SellPrice}
FROM ${ShopItemsListFiled.TableName}
INNER JOIN ${ItemFiled.TableName} 
ON ${ShopItemsListFiled.TableName}.${ShopItemsListFiled.ItemName} = ${ItemFiled.TableName}.${ItemFiled.ItemName} ;
''');
    for (var ll in l) {
      if (ll[ShopItemsListFiled.ShopName] == shop) {
        lll.add(ll);
      }
    }

    return lll;
  }

  static Future<List<Map>> readAll() async {
    final db = await DatabaseHelper.instace.databese;
    try {
      final map = await db.query(
        ShopItemsListFiled.TableName,
      );
      return map;
    } catch (e) {
      return [
        {"not": "e.toString()"}
      ];
    }
  }

  static Future<List<String>> readAllShopName() async {
    final db = await DatabaseHelper.instace.databese;
    final List<String> ShopNames = [];
    try {
      final map = await db.query(
        ShopItemsListFiled.TableName,
      );

      for (var item in map) {
        if (!ShopNames.contains(item[ShopItemsListFiled.ShopName])) {
          ShopNames.add(item[ShopItemsListFiled.ShopName].toString());
        }
      }
      return ShopNames;
    } catch (e) {
      return ShopNames;
    }
  }

  static Future<int> updataSelled(String ItemName, value) async {
    // final db = await DatabaseHelper.instace.databese;
    Map oldData = await DBShopItemsList.read(ItemName);
    int oldRemind = oldData[ShopItemsListFiled.Remind];
    int oldSell = oldData[ShopItemsListFiled.Selled];

    print(oldRemind - value);
    if (oldRemind < value) {
      return 2;
    } else {
      try {
        await DBShopItemsList.update({
          ShopItemsListFiled.Selled: oldSell + value,
          ShopItemsListFiled.Remind: oldRemind - value
        }, itemName: ItemName);
        return 1;
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    }
  }

  static Future<int> updateRemind(String ItemName,
      {required int valueToAdd}) async {
    Map oldData = await DBShopItemsList.read(ItemName);
    int oldRemind = oldData[ShopItemsListFiled.Remind];
    Map Stock = await DBItem.read(ItemName);
    int StockNum = Stock[ItemFiled.StockNum];
    int newVale = StockNum - valueToAdd;
    if (newVale < 0) {
      return 2;
    } else {
      await DBItem.update({ItemFiled.StockNum: newVale}, itemName: ItemName);

      print(oldRemind + valueToAdd);

      try {
        await DBShopItemsList.update(
          {ShopItemsListFiled.Remind: oldRemind + valueToAdd},
          itemName: ItemName,
        );
        return 1;
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    }
  }

  static Future<int> deleteAndMoveToStock(
      {required String itemName, required String itemShop}) async {
    Map oldData = await DBShopItemsList.read(itemShop);
    int itemRemind = oldData[ShopItemsListFiled.Remind];
    Map OldItemData = await DBItem.read(itemName);
    int OldItemStock = OldItemData[ItemFiled.StockNum];
    print(itemRemind);
    print(OldItemStock);
    try {
      if (itemRemind == 0) {
        await DBShopItemsList.deleteItemShop(itemShopNameToDelete: itemShop);
        return 1;
      } else {
        Map OldItemData = await DBItem.read(itemName);
        int OldItemStock = OldItemData[ItemFiled.StockNum];
        await DBItem.update({ItemFiled.StockNum: OldItemStock + itemRemind},
            itemName: itemName);
        await DBShopItemsList.deleteItemShop(itemShopNameToDelete: itemShop);

        return 1;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<int> deleteItem({required String itemNameToDelete}) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.delete(ShopItemsListFiled.TableName,
          where: '${ShopItemsListFiled.ItemName} = ?',
          whereArgs: [itemNameToDelete]);
      return 1;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> deleteItemShop(
      {required String itemShopNameToDelete}) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.delete(ShopItemsListFiled.TableName,
          where: '${ShopItemsListFiled.ItemShop} = ?',
          whereArgs: [itemShopNameToDelete]);
      return 1;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> deleteShop({required String shopNameToDelete}) async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.delete(ShopItemsListFiled.TableName,
          where: '${ShopItemsListFiled.ShopName} = ?',
          whereArgs: [shopNameToDelete]);
      return 1;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> deleteAll() async {
    final db = await DatabaseHelper.instace.databese;
    try {
      await db.delete(ShopItemsListFiled.TableName);
      return 1;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<int> addToRemind(
      {required String item,
      required bool fromStock,
      required int valueToAdd,
      required int newValue}) async {
    try {
      if (fromStock) {
        Map oldStock = await DBItem.read(item);
        await DBItem.update(
            {ItemFiled.StockNum: oldStock[ItemFiled.StockNum] - valueToAdd},
            itemName: item);
        await DBShopItemsList.update({ShopItemsListFiled.Remind: newValue},
            itemName: item);
        print(oldStock);
      } else {
        await DBShopItemsList.update({ShopItemsListFiled.Remind: newValue},
            itemName: item);
      }
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<int> removeFromRemind(
      {required String item,
      required bool toStock,
      required int valueToAdd,
      required int newValue}) async {
    try {
      if (toStock) {
        Map oldStock = await DBItem.read(item);
        await DBItem.update(
            {ItemFiled.StockNum: oldStock[ItemFiled.StockNum] + valueToAdd},
            itemName: item);
        await DBShopItemsList.update({ShopItemsListFiled.Remind: newValue},
            itemName: item);
        print(oldStock);
      } else {
        await DBShopItemsList.update({ShopItemsListFiled.Remind: newValue},
            itemName: item);
      }
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }

// static Future<int> updataReminFromDaily(int oldRemind)async{

// }
}
////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
