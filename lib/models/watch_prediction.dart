class WatchPrediction {
  final int? id; // ID dari database Supabase (bisa null sebelum di-create)
  final String homeTeam;
  final String awayTeam;
  final int predictedHomeScore;
  final int predictedAwayScore;
  final String note;

  WatchPrediction({
    this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.predictedHomeScore,
    required this.predictedAwayScore,
    this.note = '',
  });

  // Untuk membaca data (Read) dari Supabase JSON ke Dart
  factory WatchPrediction.fromJson(Map<String, dynamic> json) {
    return WatchPrediction(
      id: json['id'],
      homeTeam: json['home_team'] ?? '',
      awayTeam: json['away_team'] ?? '',
      predictedHomeScore: json['predicted_home_score'] ?? 0,
      predictedAwayScore: json['predicted_away_score'] ?? 0,
      note: json['note'] ?? '',
    );
  }

  // Untuk mengirim data (Create/Update) dari Dart ke Supabase JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'home_team': homeTeam,
      'away_team': awayTeam,
      'predicted_home_score': predictedHomeScore,
      'predicted_away_score': predictedAwayScore,
      'note': note,
    };
  }
}
