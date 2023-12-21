import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String shoppingListTable = 'shoppingListTable';
const String idColumn = 'idColumn';
const String itemColumn = 'itemColumn';
const String amountColumn = 'amountColumn';
const String brandColumn = 'brandColumn';
const String checkedColumn = 'checkedColumn';
const String categoryColumn = 'categoryColumn';

class ShoppingItemHelper {
  static final ShoppingItemHelper _instance = ShoppingItemHelper.internal();

  ShoppingItemHelper.internal();

  factory ShoppingItemHelper() => _instance;

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "shopping_list.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute('CREATE TABLE $shoppingListTable ('
          '$idColumn INTEGER PRIMARY KEY, '
          '$itemColumn TEXT, '
          '$amountColumn INTEGER, '
          '$brandColumn TEXT, '
          '$categoryColumn TEXT'
          '$checkedColumn INTEGER'
          ')');
    });
  }

  Future<ShoppingItem> saveShoppingItem(ShoppingItem shoppingItem) async {
    print("salvar");
    Database? dbShoppingItem = await db;
    shoppingItem.id =
        await dbShoppingItem?.insert(shoppingListTable, shoppingItem.toMap());
    return shoppingItem;
  }

  void alterTable() async {
    Database? dbShoppingItem = await db;
    await dbShoppingItem!.rawQuery(
        "ALTER TABLE $shoppingListTable ADD COLUMN $checkedColumn TEXT");
  }

  Future<ShoppingItem?> getShoppingItem(int id) async {
    Database? dbShoppingItem = await db;
    List<Map> maps = await dbShoppingItem!.query(shoppingListTable,
        columns: [
          idColumn,
          itemColumn,
          amountColumn,
          brandColumn,
          checkedColumn
        ],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ShoppingItem.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteShoppingItem(int id) async {
    Database? dbShoppingItem = await db;
    return await dbShoppingItem!.delete(
      shoppingListTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateShoppingItem(ShoppingItem shoppingItem) async {
    Database? dbShoppingItem = await db;
    return await dbShoppingItem!.update(
      shoppingListTable,
      shoppingItem.toMap(),
      where: '$idColumn = ?',
      whereArgs: [shoppingItem.id],
    );
  }

  Future<List<ShoppingItem>> getAllShoppingItems() async {
    Database? dbShoppingItem = await db;
    List listMap = await dbShoppingItem!.rawQuery('SELECT * FROM $shoppingListTable');
    List<ShoppingItem> listShoppingItem = [];
    for (Map m in listMap) {
      listShoppingItem.add(ShoppingItem.fromMap(m));
    }
    return listShoppingItem;
  }

  Future<int?> getNumber() async {
    Database? dbShoppingItem = await db;
    return Sqflite.firstIntValue(await dbShoppingItem!
        .rawQuery('SELECT COUNT(*) FROM $shoppingListTable'));
  }

  Future<void> close() async {
    Database? dbShoppingItem = await db;
    dbShoppingItem!.close();
  }
}

class ShoppingItem {
  int? id;
  String? item;
  int? amount;
  String? brand;
  int? checked;
  String? category;

  ShoppingItem();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      itemColumn: item,
      amountColumn: amount,
      brandColumn: brand,
      checkedColumn: checked,
      categoryColumn: category,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  ShoppingItem.fromMap(Map map) {
    id = map[idColumn];
    item = map[itemColumn];
    amount = map[amountColumn];
    brand = map[brandColumn];
    checked = map[checkedColumn];
    category = map[categoryColumn];
  }

  @override
  String toString() {
    return 'ShoppingItem(id: $id, item: $item, amount: $amount, brand: $brand, category: $category, checked: $checked)';
  }
}
