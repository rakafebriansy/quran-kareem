import 'package:get/get.dart';
import 'package:quran_kareem/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.HOME);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
