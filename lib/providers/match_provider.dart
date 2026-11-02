import 'package:flutter/material.dart';

import '../models/match_model.dart';
import '../repositories/match_repository.dart';

class MatchProvider extends ChangeNotifier {
  final MatchRepository _repository = MatchRepository();

  List<MatchModel> _matches = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getter agar UI bisa membaca state ini
  List<MatchModel> get matches => _matches;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk mengambil data
  Future<void> fetchMatches() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners(); // Memberitahu UI untuk memunculkan animasi loading

    try {
      _matches = await _repository.getMatches();
    } catch (e) {
      _errorMessage =
          'Gagal memuat jadwal pertandingan. Periksa koneksi internet Anda.';
    } finally {
      _isLoading = false;
      notifyListeners(); // Memberitahu UI bahwa proses loading selesai
    }
  }
}
