import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BairroMaisApp());
}

class BairroMaisApp extends StatelessWidget {
  const BairroMaisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BairroMais',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}