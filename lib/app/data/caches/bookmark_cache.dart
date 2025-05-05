import 'dart:convert';

import 'package:quran_kareem/app/data/models/bookmark_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkCache {
  Future<List<BookmarkModel>> getAllBookmarkFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookmarksJson = prefs.getString('bookmarks');

    if (bookmarksJson != null) {
      final List data = jsonDecode(bookmarksJson);
      return data.map((json) => BookmarkModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> addBookmarkToCache(BookmarkModel newBookmark) async {
    final prefs = await SharedPreferences.getInstance();

    List<BookmarkModel> bookmarks = await getAllBookmarkFromCache();

    if (!bookmarks.any(
      (b) =>
          b.surahNumber == newBookmark.surahNumber &&
          b.verseNumber == newBookmark.verseNumber,
    )) {
      bookmarks.add(newBookmark);
    }

    final String updatedJson = jsonEncode(
      bookmarks.map((b) => b.toJson()).toList(),
    );
    prefs.setString('bookmarks', updatedJson);
  }

  Future<void> removeBookmarkFromCache(BookmarkModel targetBookmark) async {
    final prefs = await SharedPreferences.getInstance();
    List<BookmarkModel> bookmarks = await getAllBookmarkFromCache();

    if (bookmarks.isNotEmpty) {
      bookmarks.removeWhere(
        (b) =>
            b.surahNumber == targetBookmark.surahNumber &&
            b.verseNumber == targetBookmark.verseNumber,
      );

      final String updatedJson = jsonEncode(
        bookmarks.map((b) => b.toJson()).toList(),
      );

      await prefs.setString('bookmarks', updatedJson);
    }
  }

  Future<bool> checkIsBookmarkedFromCache(BookmarkModel bookmark) async {
    List<BookmarkModel> bookmarks = await getAllBookmarkFromCache();

    if (bookmarks.isNotEmpty) {
      return bookmarks.any(
        (b) =>
            b.surahNumber == bookmark.surahNumber &&
            b.verseNumber == bookmark.verseNumber,
      );
    }

    return false;
  }
}
