import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/routes/app_pages.dart';
import 'package:quran_kareem/app/widgets/home/card_menu.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConstants.homeBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(height: 190),
                        GestureDetector(
                          onTap:
                              () => Get.toNamed(
                                Routes.SURAH,
                                arguments:
                                    controller.pinnedSurah.value!.number,
                              ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: ColorConstants.cardGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Obx(() {
                              return controller.pinnedSurah.value != null &&
                                      controller.pinnedAyah.value != null
                                  ? Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .pinnedSurah
                                                          .value!
                                                          .latinName,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                    ),
                                                    Text(
                                                      'Ayat no: ${controller.pinnedAyah.value!.number}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.white
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 8,
                                                  ),
                                                  child: Text(
                                                    'Terakhir dibaca',
                                                    style: GoogleFonts.poppins(
                                                      color:
                                                          Colors
                                                              .white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                  : Text(
                                    'Terakhir Dibaca Belum Ada',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  );
                            }),
                          ),
                        ),
                        SizedBox(height: 24),
                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          crossAxisCount: 2,
                          children: [
                            CardMenu(
                              count: 1,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'سورة',
                              latinTitle: 'Surah',
                              onPressed:
                                  () =>
                                      Get.toNamed(Routes.SURAH_LIST)!.then((_) {
                                        controller.fetchPinnedSurah();
                                      }),
                            ),
                            CardMenu(
                              count: 2,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'محفوظ',
                              latinTitle: 'Tersimpan',
                              onPressed: () {
                                Get.toNamed(Routes.BOOKMARKS);
                              },
                            ),
                            CardMenu(
                              count: 3,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'سورة يس',
                              latinTitle: 'Surah Yasin',
                              onPressed:
                                  () => Get.toNamed(
                                    Routes.SURAH,
                                    arguments: 36,
                                  )!.then((_) {
                                    controller.fetchPinnedSurah();
                                  }),
                            ),
                            CardMenu(
                              count: 4,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'آيت الكرسي',
                              latinTitle: 'Ayat Al-kursi',
                              onPressed:
                                  () => Get.toNamed(
                                    Routes.AYAT_AL_KURSI,
                                    arguments: 36,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SlideTransition(
                        position: controller.slideAnimation,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            child: Image.asset(
                              AssetConstants.shiningQuranDecoration,
                              width: screenSize.width * 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
