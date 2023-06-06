import 'package:flutter/material.dart';
import 'package:proj/pages/login.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fasi Network',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Login(),
    );
  }
}
