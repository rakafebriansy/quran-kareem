import 'package:quran_kareem/app/data/caches/surah_cache.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/providers/surah_api_provider.dart';

class SurahRepository {
  final SurahApiProvider surahApiProvider;
  final SurahCache surahCache;

  SurahRepository(this.surahApiProvider, this.surahCache);

  Future<List<SurahModel>> getSurahs() async {
    List<SurahModel> surahs = await surahCache.getSurahsFromCache();

    if (surahs.isNotEmpty) {
      print('From cacje');
      return surahs;
    } else {
      print('from api');
      final SurahResponse response =
          await surahApiProvider.fetchSurahsFromApi();
      await surahCache.saveSurahsToCache(response.data);
      return response.data;
    }
  }
}
