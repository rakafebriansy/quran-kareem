import 'package:get/get.dart';

import '../controllers/ayat_al_kursi_controller.dart';

class AyatAlKursiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AyatAlKursiController>(
      () => AyatAlKursiController(),
    );
  }
}
