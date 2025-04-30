import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/routes/app_pages.dart';
import 'package:quran_kareem/app/widgets/app_bar_menu.dart';
import 'package:quran_kareem/app/widgets/home/card_menu.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarMenu(),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(height: 190),
                        Container(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetConstants.recentlyAyatDefault,
                                width: 240,
                              ),
                              SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Al-Fatihah',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Ayat no: 1',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Terakhir dibaca',
                                      style: GoogleFonts.poppins(
                                        color: ColorConstants.darkShapeColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                              onPressed: () {
                                Get.toNamed(Routes.SURAH_LIST);
                              },
                            ),
                            CardMenu(
                              count: 2,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'محفوظ',
                              latinTitle: 'Tersimpan',
                              onPressed: () {},
                            ),
                            CardMenu(
                              count: 3,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'سورة يس',
                              latinTitle: 'Surah Yasin',
                              onPressed: () {},
                            ),
                            CardMenu(
                              count: 4,
                              gradient: ColorConstants.cardGradient,
                              arabicTitle: 'آيت الكرسي',
                              latinTitle: 'Ayat Al-kursi',
                              onPressed: () {},
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
                              AssetConstants.quranDecoration,
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
