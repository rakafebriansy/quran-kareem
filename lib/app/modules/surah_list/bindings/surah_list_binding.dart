import 'package:get/get.dart';

import '../controllers/surah_list_controller.dart';

class SurahListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurahListController>(
      () => SurahListController(),
    );
  }
}
