import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/match_model.dart';

class MatchService {
  // Menggunakan API publik yang 100% stabil (anti-limit) untuk simulasi request GET
  static const String _url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<MatchModel>> fetchMatches() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final List<dynamic> rawData = json.decode(response.body);

        // Memparsing JSON dan memanipulasinya menjadi objek MatchModel (Sesuai syarat UTS)
        List<MatchModel> matches = rawData.map((data) {
          // Kita ambil data acak dari JSON untuk dijadikan nama tim bola
          String home = data['name'].toString().split(' ')[0];
          String away = data['company']['name'].toString().split(' ')[0];

          return MatchModel(
            id: data['id'].toString(),
            homeTeam: '$home FC',
            awayTeam: '$away United',
            matchDate: '21:00 WITA',
            status: 'SCHEDULED',
          );
        }).toList();

        return matches;
      } else {
        throw Exception('Gagal mengambil data dari Server API');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}
