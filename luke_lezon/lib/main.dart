import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/books_page.dart';
import 'pages/messages_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F1DD), // Cor de fundo global
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F1DD), // Cor de fundo da AppBar
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/about': (_) => const AboutPage(),
        '/books': (_) => const BooksPage(),
        '/messages': (_) => const MessagesPage(),
      },
    );
  }
}
