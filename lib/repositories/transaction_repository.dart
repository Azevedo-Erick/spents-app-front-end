import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/transaction_model.dart';

class TransactionRepository extends ChangeNotifier {
  TransactionRepository();

  //List<Transaction> _transactions = [];

  //UnmodifiableListView<Transaction> get transactions =>
  //  UnmodifiableListView(_transactions);

  Future<List<Transaction>> getAllTransactions() async {
    List<Transaction> transactions = [];
    http.Response response =
        await http.get(Uri.parse('http://localhost:3000/transaction'));
    var results = jsonDecode(response.body);
    if (results != null) {
      for (int i = 0; i < results.length; i++) {
        transactions.add(Transaction.fromJson(results[i]));
      }
    }
    return transactions;
  }

  //Create transaction
  Future<void> createTransaction(String body) async {
    http.Response response = await http.post(
      Uri.parse('http://localhost:3000/transaction'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      getAllTransactions();
    }
  }
}
