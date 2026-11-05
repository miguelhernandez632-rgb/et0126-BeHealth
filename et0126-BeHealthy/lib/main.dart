import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BeHealthyApp());
}

class BeHealthyApp extends StatelessWidget {
  const BeHealthyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeHealthy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}
