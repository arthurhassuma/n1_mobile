import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FILMU - Seu APP de Recomendações de Filmes',
      theme: ThemeData(
        primaryColor: const Color(0xFF38c958),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFaee637),
        ),
        scaffoldBackgroundColor: const Color(0x0FF383939), // Fundo do app
        textTheme: TextTheme(
          // Use os novos parâmetros
          bodyMedium: const TextStyle(color: Color(0xFFFFFFFF)), // Anteriormente 'bodyText1'
          bodySmall: const TextStyle(color: Color(0xFFFFFFFF)), // Anteriormente 'bodyText2'
          titleMedium: const TextStyle(color: Color(0xFFFFFFFF)), // Anteriormente 'headline6'
        ),
      ),
      home: const HomePage(),
    );
  }
}
