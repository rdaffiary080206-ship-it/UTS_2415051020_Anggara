import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/watchlist_provider.dart';
import '../models/watch_prediction.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    // Memanggil data dari Supabase saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistProvider>().fetchWatchlist();
    });
  }

  // Fungsi memunculkan form pop-up untuk menambah data
  void _showAddDialog() {
    final homeController = TextEditingController();
    final awayController = TextEditingController();
    final homeScoreController = TextEditingController();
    final awayScoreController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: const Text(
            'Tambah Prediksi',
            style: TextStyle(color: Colors.greenAccent),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: homeController,
                  decoration: const InputDecoration(
                    labelText: 'Tim Kandang (Home)',
                  ),
                ),
                TextField(
                  controller: awayController,
                  decoration: const InputDecoration(
                    labelText: 'Tim Tandang (Away)',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: homeScoreController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Skor Home',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: awayScoreController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Skor Away',
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (Opsional)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () async {
                // Bungkus data ke dalam Model
                final prediction = WatchPrediction(
                  homeTeam: homeController.text,
                  awayTeam: awayController.text,
                  predictedHomeScore:
                      int.tryParse(homeScoreController.text) ?? 0,
                  predictedAwayScore:
                      int.tryParse(awayScoreController.text) ?? 0,
                  note: noteController.text,
                );

                // Kirim ke Provider -> Repository -> Supabase
                final success = await context
                    .read<WatchlistProvider>()
                    .addPrediction(prediction);
                if (success && context.mounted) {
                  Navigator.pop(context); // Tutup Pop-up form
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil menyimpan prediksi!'),
                    ),
                  );
                }
              },
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Watchlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<WatchlistProvider>(
        builder: (context, provider, child) {
          // State 1: Loading
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            );
          }

          // State 2: Error
          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                provider.errorMessage,
                style: const TextStyle(color: Colors.grey),
              ),
            );
          }

          // State 3: Kosong
          if (provider.predictions.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada prediksi. Klik + untuk menambah.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // State 4: Ada Data (Sukses READ)
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.predictions.length,
            itemBuilder: (context, index) {
              final item = provider.predictions[index];
              return Card(
                color: const Color(0xFF2C2C2C),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    '${item.homeTeam} vs ${item.awayTeam}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Tebakan Skor: ${item.predictedHomeScore} - ${item.predictedAwayScore}\nCatatan: ${item.note}',
                    style: const TextStyle(color: Colors.greenAccent),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () async {
                      // Fungsi DELETE
                      if (item.id != null) {
                        await provider.removePrediction(item.id!);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Data dihapus')),
                          );
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      // Tombol melayang untuk CREATE Data
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
