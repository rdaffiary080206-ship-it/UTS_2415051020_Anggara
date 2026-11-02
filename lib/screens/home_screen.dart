import 'package:flutter/material.dart';

import '../widgets/match_card.dart'; // Import Reusable Widget Anda

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: const [
          MatchCard(
            homeTeam: 'Real Madrid',
            awayTeam: 'Barcelona',
            timeOrScore: '2 - 1',
            status: 'FT',
          ),
          MatchCard(
            homeTeam: 'Man United',
            awayTeam: 'Liverpool',
            timeOrScore: '22:00',
            status: 'SCHEDULED',
          ),
          MatchCard(
            homeTeam: 'AC Milan',
            awayTeam: 'Inter Milan',
            timeOrScore: '0 - 0',
            status: 'LIVE 45\'',
          ),
        ],
      ),
    );
  }
}
