import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/widgets/app_bar_menu.dart';

import '../controllers/surah_controller.dart';

class SurahView extends GetView<SurahController> {
  const SurahView({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ScrollController _controller = ScrollController();

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
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            gradient: ColorConstants.cardGradient.withOpacity(
                              0.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('data')
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Scrollbar(
                            thickness: 8,
                            thumbVisibility: true,
                            controller: _controller,
                            interactive: true,
                            child: Obx(
                              () => ListView.builder(
                                controller: _controller,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: controller.surah.value.ayah?.length,
                                itemBuilder: (context, index) {
                                  if (controller.surah.value.ayah != null && controller.surah.value.ayah!.isNotEmpty) {
                                    return Column(
                                      children: [
                                        Text(controller.surah.value.ayah![index].latinText),
                                        Divider(color: Colors.white),
                                      ],
                                    );
                                  }
                                  return Center(
                                    child: Text(
                                      controller.surah.value.ayah.toString(),
                                      style: GoogleFonts.poppins(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Image.asset(
                            AssetConstants.quranDecoration,
                            width: screenSize.width * 0.6,
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
