import 'package:spents_app/models/category_model.dart';
import 'package:spents_app/models/type_enum.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

import '../../database/db.dart';
import '../../models/transaction_model.dart';
import 'category_repository.dart';

class TransactionRepository {
  late DB _database;
  TransactionRepository() {
    _database = DB.instance;
  }
  Future<List<Transaction>> getMany() async {
    List<Transaction> transactions = [];

    final sqlite.Database db = await _database.database;

    final List<Map<String, dynamic>> maps = await db.query('transactions');
    for (int i = 0; i < maps.length; i++) {
      Category category =
          await CategoryRepository().getById(maps[i]['category_id']);

      transactions.add(Transaction(
        id: maps[i]['id'].toString(),
        title: maps[i]['title'],
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description'],
        type: Type.values[maps[i]['type']],
        value: 0,
        category: category,
      ));
    }

    Category cat = Category(id: '0', name: '', color: '');
    CategoryRepository().getById(1).then((value) => cat = value);
    create(
      Transaction(
          id: '1',
          title: 'Test',
          value: 0,
          category: cat,
          date: DateTime.parse('2020-01-01'),
          description: '',
          type: Type.SPENT),
    );

    return transactions;
  }

  Future<void> create(Transaction transaction) async {
    final sqlite.Database db = await _database.database;
    await db.insert('transactions', transaction.toJson(),
        conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
  }

  Future<void> delete(Transaction transaction) async {
    final sqlite.Database db = await _database.database;
    await db
        .delete('transactions', where: 'id = ?', whereArgs: [transaction.id]);
  }

  Future<void> update(Transaction transaction) async {
    final sqlite.Database db = await _database.database;
    await db.update('transactions', transaction.toJson(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }

  Future<List<Transaction>> getOneWeek(
      DateTime startDate, DateTime finalDate) async {
    final sqlite.Database db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('transactions',
        where: 'date BETWEEN ? AND ?', whereArgs: [startDate, finalDate]);

    List<Transaction> transactions = [];
    if (maps.isEmpty) {
      return transactions;
    }
    Category cat = Category(id: '0', name: '', color: '');
    for (int i = 0; i < maps.length; i++) {
      transactions.add(Transaction(
        id: maps[i]['id'].toString(),
        title: maps[i]['title'],
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description'],
        type: Type.values[maps[i]['type']],
        value: 0,
        category: cat,
      ));
    }
    return transactions;
  }
}
