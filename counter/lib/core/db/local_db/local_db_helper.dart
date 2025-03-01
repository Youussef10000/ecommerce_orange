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
      CREATE TABLE IF NOT EXISTS products(
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        image TEXT,
        quantity INTEGER NOT NULL DEFAULT 1,
        price REAL NOT NULL
      )
    """);
    debugPrint("Table Created");
  }

  // ✅ Add Product (Handles Duplicates & Increases Quantity)
  static Future<void> add(String productId, String name, String description, String imageUrl, int quantity, double price) async {
    final db = await initDb();

    // Check if product exists
    final existingProduct = await db.query("products", where: "id = ?", whereArgs: [productId]);

    if (existingProduct.isNotEmpty) {
      int currentQuantity = (existingProduct.first["quantity"] as int?) ?? 1; // ✅ Fix
      int newQuantity = currentQuantity + quantity;

      await updateQuantity(productId, newQuantity);
      debugPrint("Quantity updated for existing product");
    } else {
      // Insert new product
      final data = {
        'id': productId,
        'title': name,
        'description': description,
        'image': imageUrl,
        'quantity': quantity,
        'price': price
      };

      await db.insert('products', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
      debugPrint("New Product Added to Cart");
    }
  }

  // ✅ Get Products from Database
  static Future<List<Map<String, dynamic>>> get() async {
    final db = await initDb();
    return db.query('products', orderBy: "id");
  }

  // ✅ Update Quantity of a Product
  static Future<void> updateQuantity(String productId, int newQuantity) async {
    final db = await initDb();
    try {
      await db.update(
        "products",
        {'quantity': newQuantity},
        where: "id = ?",
        whereArgs: [productId],
      );
      debugPrint("Product Quantity Updated");
    } catch (err) {
      debugPrint("Something went wrong when updating quantity: $err");
    }
  }

  // ✅ Delete a Product from Cart
  static Future<void> delete(String productId) async {
    final db = await initDb();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [productId]);
      debugPrint("Product Removed from Cart");
    } catch (err) {
      debugPrint("Something went wrong: $err");
    }
  }
}
