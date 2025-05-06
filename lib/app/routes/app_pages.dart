import 'package:get/get.dart';

import '../modules/bookmarks/bindings/bookmarks_binding.dart';
import '../modules/bookmarks/views/bookmarks_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/surah/bindings/surah_binding.dart';
import '../modules/surah/views/surah_view.dart';
import '../modules/surah_list/bindings/surah_list_binding.dart';
import '../modules/surah_list/views/surah_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SURAH_LIST,
      page: () => SurahListView(),
      binding: SurahListBinding(),
    ),
    GetPage(
      name: _Paths.SURAH,
      page: () => const SurahView(),
      binding: SurahBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKS,
      page: () => BookmarksView(),
      binding: BookmarksBinding(),
    ),
  ];
}
