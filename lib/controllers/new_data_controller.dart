import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spents_app/models/category_model.dart';

import '../models/transaction_model.dart';
import '../repositories/category_repository.dart';
import '../repositories/transaction_repository.dart';

class NewDataController extends ChangeNotifier {
  NewDataController();

  List<Category> _categories = [];

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

  void addTransaction(Transaction transaction) {
    String body = jsonEncode(transaction.toJson());
    TransactionRepository repo = TransactionRepository();
    repo.create(transaction).then((value) {
      notifyListeners();
    });
  }

  void addCategory(Category category) {
    CategoryRepository repo = CategoryRepository();
    repo.create(category).then((value) {
      _categories.clear();
      categories;
      notifyListeners();
    });
  }
}
