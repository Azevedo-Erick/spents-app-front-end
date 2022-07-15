import 'package:flutter/material.dart';

class NewSpentPage extends StatefulWidget {
  const NewSpentPage({Key? key}) : super(key: key);
  @override
  _NewSpentPageState createState() => _NewSpentPageState();
}

class _NewSpentPageState extends State<NewSpentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Spent Page'),
      ),
      body: Center(
        child: Text('New Spent Page'),
      ),
    );
  }
}
