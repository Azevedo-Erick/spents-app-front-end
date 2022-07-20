import 'package:spents_app/models/category_model.dart';
import 'package:spents_app/models/type_enum.dart';

class Transaction {
  String id;
  String title;
  DateTime date;
  double value;
  String description;
  Type? type;
  Category category;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.description,
    required this.type,
    required this.category,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      value: double.parse(json['value'].toString()),
      description: json['description'],
      type: Type.getType(json['type']),
      category: Category.fromJson(json['Category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'value': value,
      'description': description,
      'type': type.toString(),
      'categoryId': category.id,
      'personId': 'cl5l8uu3o0002k6uprzzpr5u4'
    };
  }
}
