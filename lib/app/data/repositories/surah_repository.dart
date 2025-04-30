import 'package:quran_kareem/app/data/caches/surah_cache.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/providers/surah_api_provider.dart';

class SurahRepository {
  final SurahApiProvider surahApiProvider;
  final SurahCache surahCache;

  SurahRepository(this.surahApiProvider, this.surahCache);

  Future<List<SurahModel>> getAllSurah() async {
    List<SurahModel> surahs = await surahCache.getAllSurahFromCache();

    if (surahs.isNotEmpty) {
      print('From cacje');
      return surahs;
    } else {
      print('from api');
      final ListSurahResponse response =
          await surahApiProvider.getAllSurahFromApi();
      await surahCache.saveAllSurahToCache(response.data);
      return response.data;
    }
  }

  Future<SurahModel> getOneSurah(int number) async {
    SurahModel? surah = await surahCache.getOneSurahFromCache(number);

    if (surah != null) {
      print('From cacje');
      return surah;
    } else {
      print('from api');
      final SurahResponse response =
          await surahApiProvider.getOneSurahFromApi(number);
      await surahCache.saveOneSurahToCache(response.data);
      return response.data;
    }
  }
}
