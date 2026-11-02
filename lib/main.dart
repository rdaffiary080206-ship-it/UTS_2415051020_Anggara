import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MatchTrackerApp());
}

class MatchTrackerApp extends StatelessWidget {
  const MatchTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Tracker UTS',
      debugShowCheckedModeBanner:
          false, // Menghilangkan pita "DEBUG" di pojok kanan atas
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.greenAccent,
        scaffoldBackgroundColor: const Color(
          0xFF121212,
        ), // Warna latar belakang hitam elegan
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
            0xFF1F1F1F,
          ), // Warna AppBar sedikit lebih terang dari background
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
