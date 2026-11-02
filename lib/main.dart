import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/main_screen.dart';
import 'providers/match_provider.dart';
import 'providers/watchlist_provider.dart';

void main() async {
  // Wajib ditambahkan karena main() menggunakan async
  WidgetsFlutterBinding.ensureInitialized();

  // Menghubungkan aplikasi ke database Supabase Anda
  await Supabase.initialize(
    url: 'https://xmpcfjzbpecpmjcoarql.supabase.co',
    anonKey: 'sb_publishable_6BKCZcoa4xl2pF2XkbptmQ_zaif8mhr',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MatchProvider()),
        ChangeNotifierProvider(
          create: (_) => WatchlistProvider(),
        ), // Provider baru ditambahkan di sini
      ],
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
