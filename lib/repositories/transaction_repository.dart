import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/transaction_model.dart';

class TransactionRepository extends ChangeNotifier {
  TransactionRepository();

  List<Transaction> _transactions = [];

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  void getAllTransactions() async {
    _transactions.clear();
    http.Response response =
        await http.get(Uri.parse('http://localhost:3000/transaction'));
    var results = jsonDecode(response.body);
    if (results != null) {
      for (int i = 0; i < results.length; i++) {
        _transactions.add(Transaction.fromJson(results[i]));
      }
      print(_transactions);
    }
    notifyListeners();
  }

  //Create transaction
  Future<void> createTransaction(Transaction transaction) async {
    http.Response response = await http.post(
      Uri.parse('http://localhost:3000/transaction'),
      body: jsonEncode(transaction.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 201) {
      getAllTransactions();
    }
  }
}
