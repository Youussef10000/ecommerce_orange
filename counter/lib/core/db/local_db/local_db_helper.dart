import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';

class SQLHelper {
  static Future<sql.Database> initDb() async {
    return sql.openDatabase(
      'products.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE products(
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        image TEXT,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL
      )
    """);
    debugPrint("Table Created");
  }


  static Future<int> add(String productId, String name, String description, String imageUrl, int quantity, double price) async {
    final db = await initDb();
    final data = {
      'id': productId,
      'title': name,
      'description': description,
      'image': imageUrl,
      'quantity': quantity,
      'price': price
    };
    final id = await db.insert('products', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    debugPrint("Product Added to Cart");
    return id;
  }


  static Future<List<Map<String, dynamic>>> get() async {
    final db = await initDb();
    return db.query('products', orderBy: "id");
  }


  static Future<void> delete(String productId) async {
    final db = await initDb();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [productId]);
    } catch (err) {
      debugPrint("Something went wrong: $err");
    }
  }
}
