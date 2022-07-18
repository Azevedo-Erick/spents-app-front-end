import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends ChangeNotifier {
  List<Category> _categories = [];
  void getAllCategories() async {
    _categories.clear();
    http.Response response =
        await http.get(Uri.parse('http://localhost:3000/category'));
    var results = jsonDecode(response.body);
    if (results != null) {
      for (int i = 0; i < results.length; i++) {
        _categories.add(Category.fromJson(results[i]));
      }
    }
    notifyListeners();
  }

  void createCategory(Category category) async {
    http.Response response = await http.post(
      Uri.parse('http://localhost:3000/category'),
      body: jsonEncode(category.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      getAllCategories();
    }
  }

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  // Future<Category> getCategoryById(int id) => categoryDao.getCategoryById(id);
  // Future<void> insertCategory(Category category) =>
  //     categoryDao.insertCategory(category);
  // Future<void> updateCategory(Category category) =>
  //     categoryDao.updateCategory(category);
  // Future<void> deleteCategory(Category category) =>
  //     categoryDao.deleteCategory(category);
}
