import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/match_provider.dart';
import '../widgets/match_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Memanggil API otomatis saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MatchProvider>().fetchMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Matches',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<MatchProvider>(
        builder: (context, provider, child) {
          // 1. Loading State
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            );
          }

          // 2. Error State
          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        provider.fetchMatches(), // Tombol coba lagi
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: const Text(
                      'Coba Lagi',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          }

          // 3. Empty State
          if (provider.matches.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada jadwal pertandingan hari ini.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // 4. Data State (Sukses) dengan Layout Builder (Responsive)
          return LayoutBuilder(
            builder: (context, constraints) {
              // Ubah data API menjadi bentuk Widget MatchCard
              final matchCards = provider.matches.map((match) {
                return MatchCard(
                  homeTeam: match.homeTeam,
                  awayTeam: match.awayTeam,
                  timeOrScore: match.matchDate,
                  status: match.status,
                );
              }).toList();

              if (constraints.maxWidth < 600) {
                return ListView(
                  padding: const EdgeInsets.only(top: 16),
                  children: matchCards,
                );
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3.0,
                  ),
                  itemCount: matchCards.length,
                  itemBuilder: (context, index) => matchCards[index],
                );
              }
            },
          );
        },
      ),
    );
  }
}
