import 'package:get/get.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';

class SurahController extends GetxController {
  Rx<bool> isLoading = false.obs;
  late Rx<SurahModel> surah = SurahModel.empty().obs;

  final SurahRepository _surahRepository;

  SurahController(this._surahRepository);

  Future<void> fetchSurahs(int number) async {
    try {
      isLoading(true);
      surah.value = await _surahRepository.getOneSurah(number);
    } catch (error) {
      Get.snackbar('Error while fetching data', error.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as int;
    fetchSurahs(args);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
