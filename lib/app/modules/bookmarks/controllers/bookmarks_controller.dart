import 'package:get/get.dart';
import 'package:quran_kareem/app/data/caches/bookmark_cache.dart';
import 'package:quran_kareem/app/data/models/bookmark_model.dart';
import 'package:quran_kareem/app/data/models/surah_model.dart';
import 'package:quran_kareem/app/data/repositories/surah_repository.dart';

class BookmarksController extends GetxController {
  Rx<bool> isLoading = false.obs;
  RxList<BookmarkModel> bookmarks = <BookmarkModel>[].obs;
  List<SurahModel> surahs = <SurahModel>[].obs;
  RxList<SurahModel> displaySurahs = <SurahModel>[].obs;

  final SurahRepository _surahRepository;
  final BookmarkCache _bookmarkCache;

  BookmarksController(this._surahRepository, this._bookmarkCache);

  Future<void> getAllBookmarks() async {
    bookmarks.value = await _bookmarkCache.getAllBookmarkFromCache();
  }

  Future<void> fetchSurahs() async {
    try {
      isLoading(true);
      await getAllBookmarks();

      final Map<int, List<int>> bookmarkMap = {};

      for (var b in bookmarks) {
        bookmarkMap.putIfAbsent(b.surahNumber, () => []).add(b.verseNumber);
      }

      for (var entry in bookmarkMap.entries) {
        final SurahModel surah = await _surahRepository.getOneSurah(entry.key);

        if (surah.ayah != null) {
          final bookmarkedAyahs =
              surah.ayah!.where((a) => entry.value.contains(a.number)).toList();

          this.surahs.add(
            SurahModel(
              number: surah.number,
              name: surah.name,
              latinName: surah.latinName,
              numberOfVerses: surah.numberOfVerses,
              placeOfRevelation: surah.placeOfRevelation,
              meaning: surah.meaning,
              description: surah.description,
              audioFull: surah.audioFull,
              ayah: bookmarkedAyahs,
            ),
          );
        }
        displaySurahs.value = this.surahs;
      }
    } catch (error) {
      Get.snackbar('Error while fetching data', error.toString());
    } finally {
      isLoading(false);
    }
  }

  void filterList(String query) {
    if (query.isEmpty) {
      displaySurahs.value = surahs;
    } else {
      displaySurahs.value =
          surahs
              .where(
                (item) =>
                    item.latinName.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSurahs();
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
