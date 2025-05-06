import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/app/data/caches/pin_cache.dart';
import 'package:quran_kareem/app/data/models/ayah_model.dart';
import 'package:quran_kareem/app/data/models/bookmark_model.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  Rx<bool> isLoading = false.obs;
  Rx<SurahModel?> pinnedSurah = Rx<SurahModel?>(null);
  Rx<AyahModel?> pinnedAyah = Rx<AyahModel?>(null);

  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;

  final SurahRepository _surahRepository;
  final PinCache _pinCache;

  HomeController(this._surahRepository, this._pinCache);

  Future<void> fetchPinnedSurah() async {
    try {
      isLoading(true);
      final BookmarkModel? pinnedSurahModel = await _pinCache.getPinFromCache();
      pinnedSurah.value =
          pinnedSurahModel != null
              ? await _surahRepository.getOneSurah(pinnedSurahModel.surahNumber)
              : null;
      pinnedAyah.value =
          pinnedSurahModel != null
              ? pinnedSurah.value!.ayah!.firstWhere(
                (ayah) => ayah.number == pinnedSurahModel.ayahNumber,
              )
              : null;
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
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOut),
    );
    _slideAnimationController.forward();
    fetchPinnedSurah();
  }

  @override
  void onClose() {
    _slideAnimationController.dispose();
    super.onClose();
  }
}
