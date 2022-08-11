import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spents_app/models/category_model.dart';
import 'package:spents_app/models/transaction_model.dart';
import 'package:spents_app/repositories/category_repository.dart';

import 'package:spents_app/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';
import '../models/week_expenses_model.dart';

class TransactionOverviewController extends ChangeNotifier {
  TransactionOverviewController();

  List<Transaction> _transactions = [];
  List<Category> _categories = [];
  List<Transaction> _transactionsFiltered = [];
  List<WeekExpenses> _weekExpenses = [];

  UnmodifiableListView<Transaction> get transactionsFiltered {
    return UnmodifiableListView(_transactionsFiltered);
  }

  UnmodifiableListView<WeekExpenses> get weekExpenses {
    return UnmodifiableListView(_weekExpenses);
  }

  UnmodifiableListView<Category> get categories {
    if (_categories.isEmpty) {
      CategoryRepository repo = CategoryRepository();
      repo.getMany().then((value) {
        _categories = value;
        notifyListeners();
      });
    }
    return UnmodifiableListView(_categories);
  }

  UnmodifiableListView<Transaction> get transactions {
    if (_transactions.isEmpty) {
      TransactionRepository repo = TransactionRepository();
      repo.getMany().then((value) {
        _transactions = value;
        notifyListeners();
      });
    }

    return UnmodifiableListView(_transactions);
  }

  void filterTransactionsByCategory(Category? category) {
    if (category != null) {
      _transactionsFiltered = _transactions.where((transaction) {
        return transaction.category.id == category.id;
      }).toList();
    } else {
      _transactionsFiltered = _transactions;
    }
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    TransactionRepository repo = TransactionRepository();
    repo.create(transaction).then((value) {
      _transactions.add(transaction);
      notifyListeners();
    });
  }

  void getOneWeekTransactions(DateTime date) {
    String dateString = date.toString().substring(0, 10);
    TransactionRepository repo = TransactionRepository();
    repo.getOneWeek(date, date.add(Duration(days: 7))).then((value) {
      //TODO: Fazer todo o filtro de movimentações por dia da semana
      _weekExpenses = value;

      _weekExpenses.sort((a, b) {
        if (a.weekDay == 'Monday') {
          return -1;
        } else if (b.weekDay == 'Monday') {
          return 1;
        } else if (a.weekDay == 'Tuesday') {
          return -1;
        } else if (b.weekDay == 'Tuesday') {
          return 1;
        } else if (a.weekDay == 'Wednesday') {
          return -1;
        } else if (b.weekDay == 'Wednesday') {
          return 1;
        } else if (a.weekDay == 'Thursday') {
          return -1;
        } else if (b.weekDay == 'Thursday') {
          return 1;
        } else if (a.weekDay == 'Friday') {
          return -1;
        } else if (b.weekDay == 'Friday') {
          return 1;
        } else if (a.weekDay == 'Saturday') {
          return -1;
        } else if (b.weekDay == 'Saturday') {
          return 1;
        } else if (a.weekDay == 'Sunday') {
          return -1;
        } else if (b.weekDay == 'Sunday') {
          return 1;
        }
        return 0;
      });

      notifyListeners();
    });
  }

  void reloadData() {
    _transactions.clear();
    _categories.clear();
    transactions;
    categories;
    notifyListeners();
  }

  void reloadWeekExpenses() {
    _weekExpenses.clear();
    notifyListeners();
  }
}
