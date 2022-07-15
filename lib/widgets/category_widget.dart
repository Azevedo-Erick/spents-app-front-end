import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required String this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      child: Text(this.name),
    );
  }
}
