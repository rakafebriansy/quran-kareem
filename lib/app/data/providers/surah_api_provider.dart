import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:dio/dio.dart';

class SurahApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://equran.id/api/v2',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<ListSurahResponse> getAllSurahFromApi() async {
    final response = await _dio.get('/surat');
    if (response.statusCode == 200) {
      return ListSurahResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch surah from api');
    }
  }

  Future<SurahResponse> getOneSurahFromApi(int number) async {
    final response = await _dio.get('/surat/$number');
    if (response.statusCode == 200) {
      return SurahResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch surah from api');
    }
  }
}
