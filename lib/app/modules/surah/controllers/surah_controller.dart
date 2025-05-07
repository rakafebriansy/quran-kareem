import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/app/data/caches/pin_cache.dart';
import 'package:quran_kareem/app/data/models/bookmark_model.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';
import 'package:quran_kareem/app/data/caches/bookmark_cache.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<SurahModel> surah = SurahModel.empty().obs;
  Rx<BookmarkModel?> pinnedAyah = Rx<BookmarkModel?>(null);
  int? targetAyahIndex;

  final SurahRepository _surahRepository;
  final BookmarkCache _bookmarkCache;
  final PinCache _pinCache;
  final ItemScrollController itemScrollController = ItemScrollController();

  SurahController(this._surahRepository, this._bookmarkCache, this._pinCache);

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

  Future<List<BookmarkModel>> getAllBookmark(int ayahNumber) async {
    return await _bookmarkCache.getAllBookmarkFromCache();
  }

  Future<void> addToBookmark(int ayahNumber) async {
    final bookmarkModel = BookmarkModel(
      surahNumber: surah.value.number,
      ayahNumber: ayahNumber,
    );
    await _bookmarkCache.addBookmarkToCache(bookmarkModel);
  }

  Future<bool> checkIsBookmarked(int ayahNumber) async {
    final bookmarkModel = BookmarkModel(
      surahNumber: surah.value.number,
      ayahNumber: ayahNumber,
    );
    return await _bookmarkCache.checkIsBookmarkedFromCache(bookmarkModel);
  }

  Future<void> removeBookmark(int ayahNumber) async {
    final bookmarkModel = BookmarkModel(
      surahNumber: surah.value.number,
      ayahNumber: ayahNumber,
    );
    await _bookmarkCache.removeBookmarkFromCache(bookmarkModel);
  }

  Future<void> getPinnedAyah() async {
    pinnedAyah.value = await _pinCache.getPinFromCache();
  }

  Future<void> pinAyah(int ayahNumber) async {
    final newPinnedModel = BookmarkModel(
      surahNumber: surah.value.number,
      ayahNumber: ayahNumber,
    );
    await _pinCache.savePinToCache(newPinnedModel);
  }

  Future<void> removePinAyah() async {
    await _pinCache.removePinFromCache();
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, int>;
    targetAyahIndex = args['targetAyah'];
    getPinnedAyah();
    fetchSurahs(args['surahNumber']!).then((_) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (itemScrollController.isAttached && targetAyahIndex != null) {
          itemScrollController.scrollTo(
            index: targetAyahIndex!, 
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
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
}
