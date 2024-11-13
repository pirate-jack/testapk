import 'package:flutter/material.dart';
import 'package:testapk/screen/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}
