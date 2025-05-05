import 'package:get/get.dart';
import 'package:quran_kareem/app/data/models/bookmark_model.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';
import 'package:quran_kareem/app/data/caches/bookmark_cache.dart';

class SurahController extends GetxController {
  Rx<bool> isLoading = false.obs;
  late Rx<SurahModel> surah = SurahModel.empty().obs;

  final SurahRepository _surahRepository;
  final BookmarkCache _bookmarkCache;

  SurahController(this._surahRepository, this._bookmarkCache);

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
      verseNumber: ayahNumber,
    );
    await _bookmarkCache.addBookmarkToCache(bookmarkModel);
  }

  Future<bool> checkIsBookmarked(int ayahNumber) async {
    final bookmarkModel = BookmarkModel(
      surahNumber: surah.value.number,
      verseNumber: ayahNumber,
    );
    return await _bookmarkCache.checkIsBookmarkedFromCache(bookmarkModel);
  }

  Future<void> removeBookmark(int ayahNumber) async {
    final bookmarkModel = BookmarkModel(
      surahNumber: surah.value.number,
      verseNumber: ayahNumber,
    );
    await _bookmarkCache.removeBookmarkFromCache(bookmarkModel);
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
