import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/watch_prediction.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  // READ: Mengambil data dari tabel
  Future<List<WatchPrediction>> getPredictions() async {
    final response = await _supabase
        .from('watch_predictions')
        .select()
        .order('id', ascending: false); // Urutkan dari yang terbaru

    return response.map((data) => WatchPrediction.fromJson(data)).toList();
  }

  // CREATE: Menyimpan data baru
  Future<void> addPrediction(WatchPrediction prediction) async {
    await _supabase.from('watch_predictions').insert(prediction.toJson());
  }

  // DELETE: Menghapus data berdasarkan ID
  Future<void> deletePrediction(int id) async {
    await _supabase.from('watch_predictions').delete().eq('id', id);
  }
}
