import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final String timeOrScore;
  final String status;

  const MatchCard({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.timeOrScore,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(
        0xFF2C2C2C,
      ), // Warna abu-abu gelap untuk membedakan dari background
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Tim Kandang (Home)
            Expanded(
              child: Text(
                homeTeam,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            // Skor atau Waktu & Status
            Column(
              children: [
                Text(
                  timeOrScore,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            // Tim Tandang (Away)
            Expanded(
              child: Text(
                awayTeam,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
