import 'package:get/get.dart';
import 'package:quran_kareem/app/data/caches/bookmark_cache.dart';
import 'package:quran_kareem/app/data/caches/pin_cache.dart';
import 'package:quran_kareem/app/data/caches/surah_cache.dart';
import 'package:quran_kareem/app/data/providers/surah_api_provider.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';

import '../controllers/surah_controller.dart';

class SurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurahCache>(() => SurahCache());
    Get.lazyPut<PinCache>(() => PinCache());
    Get.lazyPut<BookmarkCache>(() => BookmarkCache());
    Get.lazyPut<SurahApiProvider>(() => SurahApiProvider());
    Get.lazyPut<SurahRepository>(
      () =>
          SurahRepository(Get.find<SurahApiProvider>(), Get.find<SurahCache>()),
    );
    Get.lazyPut<SurahController>(
      () => SurahController(Get.find<SurahRepository>(), Get.find<BookmarkCache>(), Get.find<PinCache>()),
    );
  }
}
