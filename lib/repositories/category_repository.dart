import 'dart:convert';

import '../models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<List<Category>> getAllCategories() async {
    List<Category> categories = [];
    http.Response response =
        await http.get(Uri.parse('http://localhost:3000/category'));
    var results = jsonDecode(response.body);
    if (results != null) {
      for (int i = 0; i < results.length; i++) {
        categories
            .add(Category(id: results[i]["id"], name: results[i]["name"]));
      }
    }
    return categories;
  }

  // Future<Category> getCategoryById(int id) => categoryDao.getCategoryById(id);
  // Future<void> insertCategory(Category category) =>
  //     categoryDao.insertCategory(category);
  // Future<void> updateCategory(Category category) =>
  //     categoryDao.updateCategory(category);
  // Future<void> deleteCategory(Category category) =>
  //     categoryDao.deleteCategory(category);
}
