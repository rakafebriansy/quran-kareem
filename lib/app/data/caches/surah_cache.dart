import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SurahCache {
  Future<List<SurahModel>> getAllSurahFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? surahsJson = prefs.getString('surahs');

    if (surahsJson != null) {
      final List data = jsonDecode(surahsJson);
      return data.map((json) => SurahModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveAllSurahToCache(List<SurahModel> surahs) async {
    final prefs = await SharedPreferences.getInstance();
    final String surahsJson = jsonEncode(
      surahs.map((surah) => surah.toJson()).toList(),
    );
    prefs.setString('surahs', surahsJson);
  }

  Future<SurahModel?> getOneSurahFromCache(int number) async {
    final prefs = await SharedPreferences.getInstance();
    final String? surahJson = prefs.getString('surah/${number}');
    print(surahJson);

    if (surahJson != null) {
      final Map<String, dynamic> data = jsonDecode(surahJson);
      print(data);
      return SurahModel.fromJson(data);
    } else {
      return null;
    }
  }

  Future<void> saveOneSurahToCache(SurahModel surah) async {
    final prefs = await SharedPreferences.getInstance();
    final String surahJson = jsonEncode(surah);
    prefs.setString('surah/${surah.number}', surahJson);
  }
}
