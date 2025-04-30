import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';

class SurahListController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;
  Animation<double> get fadeAnimation => _fadeAnimation;

  Rx<bool> isLoading = false.obs;
  RxList<SurahModel> surahs = <SurahModel>[].obs;

  final SurahRepository _surahRepository;

  SurahListController(this._surahRepository);

  Future<void> fetchSurahs() async {
    try {
      isLoading(true);
      surahs.value = await _surahRepository.getSurahs();
    } catch (error) {
      Get.snackbar('Error while fetching data', error.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOut),
    );

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeIn),
    );

    _fadeAnimationController.forward();
    _slideAnimationController.forward();

    fetchSurahs();
  }

  @override
  void onClose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.onClose();
  }
}
