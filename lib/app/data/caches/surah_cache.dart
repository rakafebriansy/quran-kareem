import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SurahCache {
  Future<List<SurahModel>> getSurahsFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? surahsJson = prefs.getString('surahs');

    if (surahsJson != null) {
      final List data = jsonDecode(surahsJson);
      return data.map((json) => SurahModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveSurahsToCache(List<SurahModel> surahs) async {
    final prefs = await SharedPreferences.getInstance();
    final String surahsJson = jsonEncode(surahs.map((surah) => surah.toJson()).toList());
    prefs.setString('surahs', surahsJson);
  }
}
