import '../models/watch_prediction.dart';
import '../services/supabase_service.dart';

class WatchlistRepository {
  final SupabaseService _service = SupabaseService();

  Future<List<WatchPrediction>> getWatchlist() async {
    return await _service.getPredictions();
  }

  Future<void> addToWatchlist(WatchPrediction prediction) async {
    await _service.addPrediction(prediction);
  }

  Future<void> removeFromWatchlist(int id) async {
    await _service.deletePrediction(id);
  }
}
