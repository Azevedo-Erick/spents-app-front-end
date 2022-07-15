import 'package:flutter/material.dart';
import 'package:spents_app/models/category_model.dart';
import 'package:spents_app/repositories/category_repository.dart';

import '../widgets/category_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    final CategoryRepository repo = CategoryRepository();
    List<CategoryWidget> categories = [];
    List<CategoryWidget> test = [];
    setState(() {
      repo.getAllCategories().then((value) =>
          value.forEach((e) => test.add(CategoryWidget(name: e.name))));
      categories = test;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index Page'),
      ),
      body: Center(
        child: Row(
          children: [
            ...categories,
            Text(categories.length.toString()),
            TextButton(
                onPressed: () => {
                      print(categories.length),
                    },
                child: Text('print'))
          ],
        ),
      ),
    );
  }
}
