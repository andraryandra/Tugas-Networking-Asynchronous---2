import 'package:flutter/material.dart';
import 'package:flutter_api/screens/homepage.dart';
// import 'dart:html';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aryand CRUD",
      home: HomePage(),
    );
  }
}
