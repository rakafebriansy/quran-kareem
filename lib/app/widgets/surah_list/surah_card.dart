import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/app/modules/surah_list/controllers/surah_list_controller.dart';

class SurahCard extends StatelessWidget {
  SurahCard({super.key, required this.index, required this.onTap});

  final VoidCallback onTap;
  final controller = Get.find<SurahListController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetConstants.frame)),
          ),
          child: Center(
            child: Text(
              controller.displaySurahs[index].number.toString(),
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ),
        title: Text(
          controller.displaySurahs[index].latinName,
          style: GoogleFonts.poppins(
            color: ColorConstants.shapeColor,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${controller.displaySurahs[index].placeOfRevelation} • ${controller.displaySurahs[index].numberOfVerses} AYAT',
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
        ),
        trailing: Text(
          controller.displaySurahs[index].name,
          style: GoogleFonts.amiri(
            color: ColorConstants.shapeColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
