import 'package:get/get.dart';
import 'package:quran_kareem/app/data/caches/surah_cache.dart';
import 'package:quran_kareem/app/data/providers/surah_api_provider.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';

import '../controllers/surah_list_controller.dart';

class SurahListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurahCache>(() => SurahCache());
    Get.lazyPut<SurahApiProvider>(() => SurahApiProvider());
    Get.lazyPut<SurahRepository>(
      () =>
          SurahRepository(Get.find<SurahApiProvider>(), Get.find<SurahCache>()),
    );
    Get.lazyPut<SurahListController>(
      () => SurahListController(Get.find<SurahRepository>()),
    );
  }
}
