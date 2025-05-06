import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/modules/surah/controllers/surah_controller.dart';
import 'package:quran_kareem/app/widgets/surah/audio_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AyahCard extends StatefulWidget {
  AyahCard({super.key, required this.index});
  final int index;

  @override
  State<AyahCard> createState() => _AyahCardState();
}

class _AyahCardState extends State<AyahCard> {
  final String appDownloadUrl = dotenv.env['APP_DOWNLOAD_URL'] ?? 'example.com';
  late SurahController controller;

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

  Future<void> checkIsBookmarked() async {
    final bool isBookmarked = await controller.checkIsBookmarked(
      controller.surah.value.ayah![widget.index].number,
    );
    if (mounted) {
      setState(() {
        this.isBookmarked = isBookmarked;
      });
    }
  }

  Future<void> toggleBookmark({required BuildContext context}) async {
    try {
      if (isBookmarked != null && isBookmarked!) {
        await controller.removeBookmark(
          controller.surah.value.ayah![widget.index].number,
        );
      } else {
        await controller.addToBookmark(
          controller.surah.value.ayah![widget.index].number,
        );
      }
      await checkIsBookmarked();
    } catch (error) {
      print(error);
    }
  }

  Future<void> togglePinAyah({
    required BuildContext context,
    required bool isPinned,
  }) async {
    try {
      if (isPinned) {
        await controller.removePinAyah();
      } else {
        await controller.pinAyah(
          controller.surah.value.ayah![widget.index].number,
        );
      }
      await controller.getPinnedAyah();
    } catch (error) {
      print(error);
    }
  }

  void copyToClipboard() {
    Clipboard.setData(
      ClipboardData(
        text:
            '${controller.surah.value.ayah![widget.index].arabText}\n\n${controller.surah.value.ayah![widget.index].meaning}',
      ),
    ).then((_) {
      Get.snackbar(
        ' ',
        'Snackbar dengan style lebih keren!',
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING, // Menampilkan snackbar melayang
        duration: Duration(seconds: 3),
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<SurahController>();
    checkIsBookmarked();
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
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetConstants.frame),
                  ),
                ),
                child: Center(
                  child: Text(
                    controller.surah.value.ayah![widget.index].number
                        .toString(),
                    style: GoogleFonts.poppins(
                      color: ColorConstants.shapeColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AyahAudioPlayer(
                    ayah: controller.surah.value.ayah![widget.index],
                    surahNumber: controller.surah.value.number,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.getPinnedAyah();
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => StatefulBuilder(
                              builder:
                                  (context, setModalState) => Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            shareAyah(
                                              context: context,
                                              ayah:
                                                  controller
                                                      .surah
                                                      .value
                                                      .ayah![widget.index]
                                                      .arabText,
                                            );
                                          },
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.share,
                                              color:
                                                  ColorConstants.darkShapeColor,
                                              size: 26,
                                            ),
                                            title: Text(
                                              'Share Ayat',
                                              style: GoogleFonts.openSans(
                                                color:
                                                    ColorConstants.darkBanner,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: () {
                                            copyToClipboard();
                                          },
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.copy,
                                              color:
                                                  ColorConstants.darkShapeColor,
                                              size: 26,
                                            ),
                                            title: Text(
                                              'Salin Ayat',
                                              style: GoogleFonts.openSans(
                                                color:
                                                    ColorConstants.darkBanner,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        if (isBookmarked != null)
                                          GestureDetector(
                                            onTap: () async {
                                              await toggleBookmark(
                                                context: context,
                                              );
                                              setModalState(() {});
                                            },
                                            child: ListTile(
                                              leading: Icon(
                                                isBookmarked!
                                                    ? Icons.bookmark_remove
                                                    : Icons.bookmark_add,
                                                color:
                                                    ColorConstants
                                                        .darkShapeColor,
                                                size: 26,
                                              ),
                                              title: Text(
                                                isBookmarked!
                                                    ? 'Hapus dari Bookmark'
                                                    : 'Simpan ke Bookmark',
                                                style: GoogleFonts.openSans(
                                                  color:
                                                      ColorConstants.darkBanner,
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(width: 12),
                                        Obx(() {
                                          final isPinned =
                                              controller
                                                      .pinnedAyah
                                                      .value
                                                      ?.surahNumber ==
                                                  controller
                                                      .surah
                                                      .value
                                                      .number &&
                                              controller
                                                      .pinnedAyah
                                                      .value
                                                      ?.ayahNumber ==
                                                  controller
                                                      .surah
                                                      .value
                                                      .ayah?[widget.index]
                                                      .number;
                                          return GestureDetector(
                                            onTap: () {
                                              togglePinAyah(
                                                context: context,
                                                isPinned: isPinned,
                                              );
                                            },
                                            child: ListTile(
                                              leading: Icon(
                                                isPinned
                                                    ? Icons.link_off
                                                    : Icons.link,
                                                color:
                                                    ColorConstants
                                                        .darkShapeColor,
                                                size: 26,
                                              ),
                                              title: Text(
                                                isPinned
                                                    ? 'Hapus Tanda Terakhir Dibaca'
                                                    : 'Tandai Terakhir Dibaca',
                                                style: GoogleFonts.openSans(
                                                  color:
                                                      ColorConstants.darkBanner,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
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
              controller.surah.value.ayah![widget.index].arabText,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              textAlign: TextAlign.right,
              controller.surah.value.ayah![widget.index].latinText,
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
              controller.surah.value.ayah![widget.index].meaning,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
