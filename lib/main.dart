import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase

import 'screens/main_screen.dart';
import 'providers/match_provider.dart';

void main() async {
  // Wajib ditambahkan jika main() menggunakan async
  WidgetsFlutterBinding.ensureInitialized();

  // Menghubungkan aplikasi ke database Supabase Anda
  await Supabase.initialize(
    url:
        'https://xmpcfjzbpecpmjcoarql.supabase.co', // URL dasar tanpa /rest/v1/
    anonKey: 'sb_publishable_6BKCZcoa4xl2pF2XkbptmQ_zaif8mhr', // Ganti dengan kunci yang berawalan 'eyJ' jika nanti error
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MatchProvider())],
      child: const MatchTrackerApp(),
    ),
  );
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
      home: const MainScreen(),
    );
  }
}
