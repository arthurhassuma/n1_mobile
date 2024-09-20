import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recomendações de Filmes',
      theme: ThemeData(
        primaryColor: Color(0xFF383939),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF38C958),
        ),
        scaffoldBackgroundColor: Color(0xFFFFEDB),
      ),
      home: HomePage(),
    );
  }
}