import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/widgets/surah/ayah_card.dart';

import '../controllers/surah_controller.dart';

class SurahView extends GetView<SurahController> {
  const SurahView({super.key});
  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
        final appBarHeight =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.surah.value.latinName,
            style: GoogleFonts.poppins(
              color: ColorConstants.shapeColor,
              fontSize: 24,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConstants.surahBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 12 + appBarHeight, 24, 24),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: ColorConstants.cardGradient.withOpacity(
                              0.7,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                offset: Offset(0, 0),
                                blurRadius: 2,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Stack(
                                  children: [
                                    Image.asset(AssetConstants.surahCardStar5),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Image.asset(
                                            AssetConstants.quranDecoration,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() {
                                return controller.isLoading.value
                                    ? SizedBox.shrink()
                                    : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.surah.value.name,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                          ),
                                        ),
                                        Text(
                                          controller.surah.value.meaning,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '${controller.surah.value.placeOfRevelation.toUpperCase()} • ${controller.surah.value.numberOfVerses} AYAT',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: Obx(() {
                            return controller.isLoading.value
                                ? SizedBox.shrink()
                                : Scrollbar(
                                  thickness: 8,
                                  thumbVisibility: true,
                                  controller: _controller,
                                  interactive: true,
                                  child: ListView.builder(
                                    controller: _controller,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.surah.value.number > 1
                                            ? controller
                                                    .surah
                                                    .value
                                                    .ayah!
                                                    .length +
                                                1
                                            : controller
                                                .surah
                                                .value
                                                .ayah
                                                ?.length,
                                    itemBuilder: (context, index) {
                                      if (controller.surah.value.ayah != null &&
                                          controller
                                              .surah
                                              .value
                                              .ayah!
                                              .isNotEmpty) {
                                        switch (index) {
                                          case 0:
                                            if (controller.surah.value.number >
                                                1) {
                                              return Container(
                                                padding: EdgeInsets.only(bottom: 30),
                                                child: Center(
                                                  child: Image.asset(
                                                    AssetConstants
                                                        .bismillahDefault,
                                                    width: 200,
                                                  ),
                                                ),
                                              );
                                            }
                                          default:
                                            return Column(
                                              children: [
                                                AyahCard(index: index - 1),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 24,
                                                      ),
                                                  child: Divider(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                        }
                                      }
                                      return controller
                                                  .surah
                                                  .value
                                                  .ayah!
                                                  .length >
                                              0
                                          ? SizedBox.shrink()
                                          : Center(
                                            child: Text(
                                              'No data',
                                              style: GoogleFonts.poppins(),
                                            ),
                                          );
                                    },
                                  ),
                                );
                          }),
                        ),
                      ],
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
