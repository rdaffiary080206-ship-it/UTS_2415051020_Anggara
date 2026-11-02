import '../models/match_model.dart';
import '../services/match_service.dart';

class MatchRepository {
  final MatchService _service = MatchService();

  // Fungsi ini yang nanti akan dipanggil oleh Provider (State Management)
  Future<List<MatchModel>> getMatches() async {
    return await _service.fetchMatches();
  }
}
