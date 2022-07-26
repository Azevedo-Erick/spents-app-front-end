import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
            child: Container(
          //background gradient dark blue to light blue
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 31, 122, 114),
                Color.fromARGB(255, 11, 20, 68),
              ],
            ),
          ),
          child: Expanded(
            child: Container(),
          ),
        )),
      ),
    );
  }
}
