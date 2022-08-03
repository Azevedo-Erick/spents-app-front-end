import 'package:spents_app/database/db.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/category_model.dart';

class CategoryRepository {
  late DB _database;

  CategoryRepository() {
    _database = DB.instance;
  }

  Future<List<Category>> getMany() async {
    List<Category> categories = [];
    final Database db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    if (maps != null) {
      for (int i = 0; i < maps.length; i++) {
        categories.add(Category.fromJson(maps[i]));
      }
    }
    return categories;
  }

  Future<void> create(Category category) async {
    final Database db = await _database.database;
    await db.insert('categories', category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(Category category) async {
    final Database db = await _database.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [category.id]);
  }

  Future<void> update(Category category) async {
    final Database db = await _database.database;
    await db.update('categories', category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
  }
}
