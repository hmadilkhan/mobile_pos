import 'package:mobile_pos/models/cart_modal.dart';
import 'package:mobile_pos/models/department_model.dart';
import 'package:mobile_pos/models/product_model.dart';
import 'package:mobile_pos/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "pos.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => _createDB(db), version: _version);
  }

  static void _createDB(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS User(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          token TEXT NULL,
          name TEXT NULL,
          company TEXT NULL,
          branch TEXT NULL
          )''');
    await db.execute('''CREATE TABLE IF NOT EXISTS Department(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          code TEXT NULL,
          name TEXT NULL,
          image TEXT NULL
          )''');
    await db.execute('''CREATE TABLE IF NOT EXISTS Product(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NULL,
          unit TEXT NULL,
          price TEXT NULL,
          department TEXT NULL,
          description TEXT NULL,
          image TEXT NULL
          )''');
    await db.execute('''CREATE TABLE IF NOT EXISTS Cart(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NULL,
          unit TEXT NULL,
          price TEXT NULL,
          department TEXT NULL,
          description TEXT NULL,
          image TEXT NULL,
          qty TEXT NULL,
          amount TEXT NULL,
          totalamount TEXT NULL
          )''');
  }

  // static void getStructure() async {
  //   final db = await _getDB();
  //   (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
  //     print(row.values);
  //   });
  // }

  static Future<int> addUser(UserModel user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(UserModel user) async {
    final db = await _getDB();
    return await db.update("User", user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteUser(UserModel user) async {
    final db = await _getDB();
    return await db.delete(
      "User",
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<List<UserModel>?> getAllUsers() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("User");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => UserModel.dbFromJson(maps[index]));
  }

  static Future<void> addCustomerDeparment() async {
    final db = await _getDB();
    await db.transaction((txn) async {
      // int id1 =
      await txn.rawInsert(
          'INSERT INTO Department(code,name,image) VALUES("1234","First Department","test.png");');
      // print('inserted1: $id1');
    });
  }

  static Future<int> addDeparment(DepartmentModel department) async {
    final db = await _getDB();
    // print("Insert Department");
    // print("From DB Method : ${department.toJson()}");
    return await db.insert("Department", department.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateDepartment(DepartmentModel department) async {
    final db = await _getDB();
    return await db.update("Department", department.toJson(),
        where: 'id = ?',
        whereArgs: [department.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteDepartment(DepartmentModel department) async {
    final db = await _getDB();
    return await db.delete(
      "Department",
      where: 'id = ?',
      whereArgs: [department.id],
    );
  }

  static Future<int> deleteAllDepartment() async {
    final db = await _getDB();
    return await db.delete(
      "Department",
      where: '1 = 1',
    );
  }

  static Future<List<DepartmentModel>?> getAllDepartment() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Department");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => DepartmentModel.dBFromJson(maps[index]));
  }

  static Future<int> addProduct(ProductModel product) async {
    final db = await _getDB();
    return await db.insert("Product", product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateProduct(ProductModel product) async {
    final db = await _getDB();
    return await db.update("Department", product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteProduct(ProductModel product) async {
    final db = await _getDB();
    return await db.delete(
      "Department",
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<int> deleteAllProduct() async {
    final db = await _getDB();
    return await db.delete(
      "Product",
      where: '1 = 1',
    );
  }

  static Future<List<ProductModel>?> getAllProducts(String? department) async {
    final db = await _getDB();
    List<Map<String, dynamic>> maps = [];
    if (department != "All") {
      maps = await db
          .query("Product", where: "department = ?", whereArgs: [department]);
    } else {
      maps = await db.query("Product");
    }

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => ProductModel.dbFromJson(maps[index]));
  }

  static getProductsByDepartment(String? department) async {
    final db = await _getDB();

    if (department != "All") {
      var result =
          db.query("Product", where: "department = ?", whereArgs: [department]);
      return result;
    } else {
      var result = await db.query("Product");
      return result;
    }
  }

  static getProductsByName(String? name) async {
    final db = await _getDB();

    if (name != "") {
      var result =
          db.query("Product", where: "name LIKE ?", whereArgs: ['%$name%']);
      return result;
    } else {
      var result = await db.query("Product");
      return result;
    }
  }

  static Future querySpecificData(int id) async {
    final db = await _getDB();
    return await db.query("Cart", where: "id = ?", whereArgs: [id]);
  }

  static Future<int> checkItemInCart(Cart cart) async {
    final db = await _getDB();
    List<Map> maps =
        await db.query("Cart", where: 'id = ?', whereArgs: [cart.id]);
    return maps.length;
  }

  static Future<int> addItemToCart(Cart cart) async {
    final db = await _getDB();
    return await db.insert("Cart", cart.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateItemToCart(Cart cart) async {
    final db = await _getDB();
    return await db.update("Cart", cart.toJson(),
        where: 'id = ?',
        whereArgs: [cart.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteItemToCart(Cart cart) async {
    final db = await _getDB();
    return await db.delete(
      "Cart",
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  static getAllItemOfCart() async {
    final db = await _getDB();
    var result = await db.query("Cart");
    return result;
  }

  static Future<int> deleteAllItemsOfCart() async {
    final db = await _getDB();
    return await db.delete(
      "Cart",
      where: '1 = 1',
    );
  }
}
