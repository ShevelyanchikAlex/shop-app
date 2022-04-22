import 'package:path/path.dart';
import 'package:shop_app/models/product.dart';
import 'package:sqflite/sqflite.dart';

import 'db_constants.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DBConstants.productsDB),
      version: 1,
      onCreate: _createTable,
    );
  }

  Future _createTable(Database db, int version) async {
    await db.execute(DBConstants.createProductTable);
  }

  Future<List<Product>> getProductList() async {
    final productList = <Product>[];
    final db = await database;
    final dbProductList = await db.query(DBConstants.productTable);
    for (final element in dbProductList) {
      productList.add(Product.fromMap(element));
    }
    return productList;
  }

  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert(
      DBConstants.productTable,
      product.toMap(),
    );
  }

  Future<int> deleteProduct(Product product) async {
    final db = await database;
    return await db.delete(
      DBConstants.productTable,
      where: '${DBConstants.productId} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> updateProduct(Product product) async {
    final db = await database;
    return await db.update(
      DBConstants.productTable,
      product.toMap(),
      where: '${DBConstants.productId} = ?',
      whereArgs: [product.id],
    );
  }

  Future<List<Product>> getFavoriteProductList() async {
    final favoriteProductList = <Product>[];
    final db = await database;
    final dbFavoriteProductList = await db.rawQuery(
        "SELECT * FROM ${DBConstants.productTable} WHERE ${DBConstants.productIsFavorite}=1");
    for (final element in dbFavoriteProductList) {
      favoriteProductList.add(Product.fromMap(element));
    }
    return favoriteProductList;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
