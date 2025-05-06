import 'dart:convert';

import 'package:quran_kareem/app/data/models/bookmark_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCache {
  Future<BookmarkModel?> getPinFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? pinnedJson = prefs.getString('pinned');

    if (pinnedJson != null) {
      final Map<String, dynamic> pinnedMap = jsonDecode(pinnedJson);
      return BookmarkModel.fromJson(pinnedMap);
    }
    return null;
  }

  Future<void> savePinToCache(BookmarkModel newPinned) async {
    final prefs = await SharedPreferences.getInstance();

    final newPinnedMap = newPinned.toJson();

    final String pinnedJson = jsonEncode(newPinnedMap);
    prefs.setString('pinned', pinnedJson);
  }

  Future<void> removePinFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('pinned');
  }
}
