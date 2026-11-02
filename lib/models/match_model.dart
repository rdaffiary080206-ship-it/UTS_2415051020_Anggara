class MatchModel {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String matchDate;
  final String status; // Misalnya: SCHEDULED, LIVE, FINISHED

  MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    required this.status,
  });

  // Factory untuk mengonversi JSON dari API menjadi Objek Dart
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'].toString(),
      homeTeam: json['home_team'] ?? 'Unknown Home',
      awayTeam: json['away_team'] ?? 'Unknown Away',
      matchDate: json['match_date'] ?? 'TBD',
      status: json['status'] ?? 'SCHEDULED',
    );
  }
}
