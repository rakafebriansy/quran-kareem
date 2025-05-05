import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/modules/surah/controllers/surah_controller.dart';
import 'package:quran_kareem/app/widgets/surah/audio_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AyahCard extends StatefulWidget {
  AyahCard({super.key, required this.controller, required this.index});
  final SurahController controller;
  final int index;

  @override
  State<AyahCard> createState() => _AyahCardState();
}

class _AyahCardState extends State<AyahCard> {
  final String appDownloadUrl = dotenv.env['APP_DOWNLOAD_URL'] ?? 'example.com';

  bool? isBookmarked;

  Future<void> shareAyah({
    required BuildContext context,
    required String ayah,
  }) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      final shareText =
          '$ayah\n\nDapatkan aplikasi Quran terbaik untuk belajar lebih dalam tentang Al-Quran. Unduh sekarang di: $appDownloadUrl';
      final params = ShareParams(
        text: shareText,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );

      await SharePlus.instance.share(params);
    } catch (error) {
      print(error);
    }
  }

  Future<void> checkIsBookmark() async {
    final bool isBookmarked = await widget.controller.checkIsBookmarked(
      widget.controller.surah.value.ayah![widget.index].number,
    );
    setState(() {
      this.isBookmarked = isBookmarked;
    });
  }

  Future<void> toggleBookmark({required BuildContext context}) async {
    try {
      await checkIsBookmark();
      if (isBookmarked != null && isBookmarked!) {
        await widget.controller.removeBookmark(
          widget.controller.surah.value.ayah![widget.index].number,
        );
        setState(() {
          isBookmarked = false;
        });
      } else {
        await widget.controller.addToBookmark(
          widget.controller.surah.value.ayah![widget.index].number,
        );
        setState(() {
          isBookmarked = true;
        });
      }
    } catch (error) {
      print(error);
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsBookmark();
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
                  widget.controller.surah.value.ayah![widget.index].number
                      .toString(),
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AyahAudioPlayer(
                    ayah: widget.controller.surah.value.ayah![widget.index],
                    surahNumber: widget.controller.surah.value.number,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      shareAyah(
                                        context: context,
                                        ayah:
                                            widget
                                                .controller
                                                .surah
                                                .value
                                                .ayah![widget.index]
                                                .arabText,
                                      );
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.share,
                                        color: ColorConstants.darkShapeColor,
                                        size: 26,
                                      ),
                                      title: Text(
                                        'Share Ayat',
                                        style: GoogleFonts.openSans(
                                          color: ColorConstants.darkBanner,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.copy,
                                        color: ColorConstants.darkShapeColor,
                                        size: 26,
                                      ),
                                      title: Text(
                                        'Salin Ayat',
                                        style: GoogleFonts.openSans(
                                          color: ColorConstants.darkBanner,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  if (isBookmarked != null)
                                    GestureDetector(
                                      onTap: () async {
                                        await toggleBookmark(context: context);
                                      },
                                      child: ListTile(
                                        leading: Icon(
                                          isBookmarked!
                                              ? Icons.bookmark_remove
                                              : Icons.bookmark_add,
                                          color: ColorConstants.darkShapeColor,
                                          size: 26,
                                        ),
                                        title: Text(
                                          isBookmarked!
                                              ? 'Hapus dari Bookmark'
                                              : 'Simpan ke Bookmark',
                                          style: GoogleFonts.openSans(
                                            color: ColorConstants.darkBanner,
                                          ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.push_pin,
                                        color: ColorConstants.darkShapeColor,
                                        size: 26,
                                      ),
                                      title: Text(
                                        'Tandai Terakhir Dibaca',
                                        style: GoogleFonts.openSans(
                                          color: ColorConstants.darkBanner,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      );
                    },
                    child: Icon(
                      Icons.more_horiz_outlined,
                      color: ColorConstants.shapeColor,
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
              widget.controller.surah.value.ayah![widget.index].arabText,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              textAlign: TextAlign.right,
              widget.controller.surah.value.ayah![widget.index].latinText,
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
              widget.controller.surah.value.ayah![widget.index].meaning,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
