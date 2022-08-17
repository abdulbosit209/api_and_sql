import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/models/product_item.dart';

import 'cached_product.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("todos.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  LocalDatabase._init();

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE $productsTable (
    ${ProductFields.id} $idType,
    ${ProductFields.count} $intType,
    ${ProductFields.productId} $intType,
    ${ProductFields.imageUrl} $textType,
    ${ProductFields.name} $textType,
    ${ProductFields.price} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $favouriteProductsTable (
    ${ProductFields.id} $idType,
    ${ProductFields.productId} $intType,
    ${ProductFields.imageUrl} $textType,
    ${ProductFields.name} $textType,
    ${ProductFields.price} $intType
    )
    ''');
  }

  //-------------------Cached Products Table-------------------
  //TODO 1 Mahsulotlar uchun tegishli querylarni yozing!

  static Future<CachedProduct> insertCachedUser(CachedProduct cachedProduct) async {
    final db = await getInstance.database;
    final id = await db.insert(productsTable, cachedProduct.toJson());
    return cachedProduct.copyWith(id: id);
  }

  static Future<int> deleteAllCachedUsers() async {
    final db = await getInstance.database;
    return await db.delete(productsTable);
  }

  static Future<int> deleteCachedUserById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(productsTable, where: "${ProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<List<CachedProduct>> getAllCachedProducts() async {
    final db = await getInstance.database;
    const orderBy = "${ProductFields.name} ASC";
    final result = await db.query(
      productsTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedProduct.fromJson(json)).toList();
  }

  static  Future<int> updateCachedProduct(CachedProduct cachedProduct) async {
    Map<String, dynamic> row = {
      ProductFields.name: cachedProduct.name,
      ProductFields.count:cachedProduct.count,
      ProductFields.productId: cachedProduct.productId,
    };

    final db = await getInstance.database;
    return await db.update(
      productsTable,
      row,
      where: '${ProductFields.id} = ?',
      whereArgs: [cachedProduct.id],
    );
  }

  //--------------------------------------------------------------------------------

  static Future<List<CachedFavouriteProduct>> getAllCachedProductsFavorite() async {
    final db = await getInstance.database;
    const orderBy = "${ProductFields.name} ASC";
    final result = await db.query(
      favouriteProductsTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedFavouriteProduct.fromJson(json)).toList();
  }

  static Future<int> deleteCachedProductsFavoriteById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(favouriteProductsTable, where: "${ProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<CachedFavouriteProduct> insertCachedProductFavorite(CachedFavouriteProduct cachedProductsFavorite) async {
    final db = await getInstance.database;
    final id = await db.insert(favouriteProductsTable, cachedProductsFavorite.toJson());
    print(id);
    return cachedProductsFavorite.copyWith(id: id);
  }

  static Future<int> deleteAllCachedProductFavorite() async {
    final db = await getInstance.database;
    return await db.delete(favouriteProductsTable);
  }


}
