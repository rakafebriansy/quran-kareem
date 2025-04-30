import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/routes/app_pages.dart';
import 'package:quran_kareem/app/widgets/app_bar_menu.dart';
import 'package:quran_kareem/app/widgets/surah_list/surah_card.dart';

import '../controllers/surah_list_controller.dart';

class SurahListView extends GetView<SurahListController> {
  SurahListView({super.key});
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarMenu(),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(height: 140),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            gradient: ColorConstants.cardGradient.withOpacity(
                              0.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            onChanged: controller.filterList,
                            decoration: InputDecoration(
                              hintText: 'Search Here',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.white54,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
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
                                    itemCount: controller.displaySurahs.length,
                                    itemBuilder: (context, index) {
                                      if (controller.displaySurahs.isNotEmpty) {
                                        return Column(
                                          children: [
                                            SurahCard(
                                              onTap:
                                                  () => Get.toNamed(
                                                    Routes.SURAH,
                                                    arguments:
                                                        controller
                                                            .displaySurahs[index]
                                                            .number,
                                                  ),
                                              controller: controller,
                                              index: index,
                                            ),
                                            Divider(color: Colors.white),
                                          ],
                                        );
                                      }
                                      return Center(
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
                              width: screenSize.width * 0.6,
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
