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
      id: json['id'].toString(),
      title: json['title'],
      date: DateTime.parse(json['date']),
      value: double.parse(json['value'].toString()),
      description: json['description'],
      type: Type.getType(json['type']),
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'value': value,
      'description': description,
      'type': type?.id.toString(),
      'category_id': category.id,
    };
  }
}
