import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'spents_app.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute('DROP TABLE IF EXISTS categories');
    await db.execute('DROP TABLE IF EXISTS transactions');
    await db.execute(_transactions);
    await db.execute(_categories);
  }

  String get _transactions => '''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      date INT,
      value TEXT,
      description TEXT,
      type INT,
      category_id INT
    )
  ''';

  String get _categories => '''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      color TEXT
    )
  ''';
}
