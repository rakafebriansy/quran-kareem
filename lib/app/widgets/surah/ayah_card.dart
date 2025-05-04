import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/modules/surah/controllers/surah_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AyahCard extends StatelessWidget {
  AyahCard({super.key, required this.controller, required this.index});
  final String appDownloadUrl = dotenv.env['APP_DOWNLOAD_URL'] ?? 'example.com';

  final SurahController controller;
  final int index;

  Future<void> shareAyah({
    required BuildContext context,
    required String ayah,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    final shareText =
        '$ayah\n\nDapatkan aplikasi Quran terbaik untuk belajar lebih dalam tentang Al-Quran. Unduh sekarang di: $appDownloadUrl';
    final params = ShareParams(
      text: shareText,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    await SharePlus.instance.share(params);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.darkBanner,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: ColorConstants.shapeColor,
                radius: 12,
                child: Text(
                  controller.surah.value.ayah![index].number.toString(),
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      shareAyah(
                        context: context,
                        ayah: controller.surah.value.ayah![index].arabText,
                      );
                    },
                    child: Icon(
                      Icons.share_outlined,
                      color: ColorConstants.shapeColor,
                      size: 26,
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.play_arrow_outlined,
                      color: ColorConstants.shapeColor,
                      size: 26,
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.bookmark_outline,
                      color: ColorConstants.shapeColor,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              controller.surah.value.ayah![index].arabText,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              textAlign: TextAlign.right,
              controller.surah.value.ayah![index].latinText,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.surah.value.ayah![index].meaning,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
