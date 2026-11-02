import 'package:flutter/material.dart';

import '../widgets/match_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy yang disimpan ke dalam list agar mudah digunakan di List maupun Grid
    final List<Widget> dummyMatches = [
      const MatchCard(
        homeTeam: 'Real Madrid',
        awayTeam: 'Barcelona',
        timeOrScore: '2 - 1',
        status: 'FT',
      ),
      const MatchCard(
        homeTeam: 'Man United',
        awayTeam: 'Liverpool',
        timeOrScore: '22:00',
        status: 'SCHEDULED',
      ),
      const MatchCard(
        homeTeam: 'AC Milan',
        awayTeam: 'Inter Milan',
        timeOrScore: '0 - 0',
        status: 'LIVE 45\'',
      ),
      const MatchCard(
        homeTeam: 'Arsenal',
        awayTeam: 'Chelsea',
        timeOrScore: '23:30',
        status: 'SCHEDULED',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Matches',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Jika lebar layar kurang dari 600px (Layar HP / Mode Compact)
          if (constraints.maxWidth < 600) {
            return ListView(
              padding: const EdgeInsets.only(top: 16),
              children: dummyMatches,
            );
          }
          // Jika lebar layar 600px atau lebih (Layar Laptop / Mode Wide)
          else {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Menampilkan 2 kolom
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3.0, // Mengatur proporsi bentuk kartu agar tidak terlalu kotak
              ),
              itemCount: dummyMatches.length,
              itemBuilder: (context, index) {
                return dummyMatches[index];
              },
            );
          }
        },
      ),
    );
  }
}
