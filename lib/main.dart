import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus',

      // ✅ THEME GLOBAL
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff188E69),
          titleTextStyle: TextStyle(
            color: Colors.white,      
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,      
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}
