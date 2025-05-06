import 'package:disclosure/disclosure.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';
import 'package:quran_kareem/app/data/models/ayah_model.dart';
import '../controllers/bookmarks_controller.dart';

class BookmarksView extends GetView<BookmarksController> {
  BookmarksView({super.key});
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    
    final appBarHeight = MediaQuery.of(context).padding.top + AppBar().preferredSize.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
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
                                hintText: 'Cari ayat tersimpan...',
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
                        ),
                        SizedBox(height: 20),
                        Container(
                          height:
                              MediaQuery.of(context).size.height -
                              (appBarHeight * 2),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: controller.displaySurahs.length,
                                    itemBuilder: (context, surahIndex) {
                                      if (controller.displaySurahs.isNotEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              Disclosure(
                                                wrapper: (state, child) {
                                                  return Card.outlined(
                                                    color: Colors.transparent,
                                                    clipBehavior: Clip.antiAlias,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      side: BorderSide(
                                                        color: Colors.white70,
                                                        width:
                                                            state.closed ? 1 : 2,
                                                      ),
                                                    ),
                                                    child: child,
                                                  );
                                                },
                                                header: DisclosureButton(
                                                  child: ListTile(
                                                    title: Text(
                                                      controller
                                                          .displaySurahs[surahIndex]
                                                          .latinName,
                                                      style: GoogleFonts.poppins(
                                                        color:
                                                            ColorConstants
                                                                .shapeColor,
                                                      ),
                                                    ),
                                                    trailing: DisclosureIcon(
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ),
                                                divider: const Divider(height: 1),
                                                child: DisclosureView(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        controller
                                                            .displaySurahs[surahIndex]
                                                            .ayah
                                                            ?.length,
                                                    itemBuilder: (
                                                      context,
                                                      ayahIndex,
                                                    ) {
                                                      final AyahModel ayah =
                                                          controller
                                                              .displaySurahs[surahIndex]
                                                              .ayah![ayahIndex];
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    ColorConstants
                                                                        .shapeColor,
                                                                radius: 12,
                                                                child: Text(
                                                                  ayah.number
                                                                      .toString(),
                                                                  style: GoogleFonts.poppins(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      ayah.arabText,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: GoogleFonts.poppins(
                                                                        color:
                                                                            Colors
                                                                                .white,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      ayah.latinText,
                                                                      style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            8,
                                                                        color:
                                                                            Colors
                                                                                .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Align(
                                                            alignment:
                                                                Alignment
                                                                    .centerLeft,
                                                            child: Text(
                                                              ayah.meaning,
                                                              style:
                                                                  GoogleFonts.poppins(
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                    fontSize: 10,
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Divider(),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
