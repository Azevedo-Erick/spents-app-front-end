import 'dart:collection';

import 'package:spents_app/models/transaction_model.dart';

class WeekExpenses {
  String _weekDay;
  List<Transaction> _transactions;

  WeekExpenses(this._weekDay, this._transactions);

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);
  String get weekDay => _weekDay;

  factory WeekExpenses.fromJson(Map<String, dynamic> json) {
    return WeekExpenses(
      json['weekDay'],
      (json['transactions'] as List)
          .map((i) => Transaction.fromJson(i))
          .toList(),
    );
  }
  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
  }
}
