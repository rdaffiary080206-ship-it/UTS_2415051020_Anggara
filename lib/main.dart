import 'package:flutter/material.dart';

import 'screens/main_screen.dart'; // Sekarang kita arahkan ke MainScreen

void main() {
  runApp(const MatchTrackerApp());
}

class MatchTrackerApp extends StatelessWidget {
  const MatchTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Tracker UTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.greenAccent,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      home: const MainScreen(), // Memanggil layar induk yang memiliki navigasi
    );
  }
}
