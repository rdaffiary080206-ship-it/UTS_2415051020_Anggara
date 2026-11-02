import 'package:flutter/material.dart';

import '../models/watch_prediction.dart';
import '../repositories/watchlist_repository.dart';

class WatchlistProvider extends ChangeNotifier {
  final WatchlistRepository _repository = WatchlistRepository();

  List<WatchPrediction> _predictions = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<WatchPrediction> get predictions => _predictions;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Mengambil data (READ)
  Future<void> fetchWatchlist() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _predictions = await _repository.getWatchlist();
    } catch (e) {
      _errorMessage = 'Gagal memuat data dari Supabase. Cek koneksi Anda.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Menambah data (CREATE)
  Future<bool> addPrediction(WatchPrediction prediction) async {
    try {
      await _repository.addToWatchlist(prediction);
      await fetchWatchlist(); // Refresh data setelah berhasil ditambah
      return true;
    } catch (e) {
      return false;
    }
  }

  // Menghapus data (DELETE)
  Future<bool> removePrediction(int id) async {
    try {
      await _repository.removeFromWatchlist(id);
      await fetchWatchlist(); // Refresh data setelah berhasil dihapus
      return true;
    } catch (e) {
      return false;
    }
  }
}
