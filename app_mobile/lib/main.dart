import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MaxwellB2BApp());
}

class MaxwellB2BApp extends StatelessWidget {
  const MaxwellB2BApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaxwellB²',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A3ECB),
          primary: const Color(0xFF6A3ECB),
          secondary: const Color(0xFF00C853),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6A3ECB),
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}