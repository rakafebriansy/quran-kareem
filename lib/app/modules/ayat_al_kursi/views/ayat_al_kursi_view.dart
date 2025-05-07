import 'package:disclosure/disclosure.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';

import '../controllers/ayat_al_kursi_controller.dart';

class AyatAlKursiView extends GetView<AyatAlKursiController> {
  AyatAlKursiView({super.key});
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ayat Al-kursi',
                style: GoogleFonts.poppins(
                  color: ColorConstants.shapeColor,
                  fontSize: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: ColorConstants.cardGradient.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Scrollbar(
                      thickness: 4,
                      thumbVisibility: true,
                      controller: _controller,
                      interactive: true,
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Image.asset(AssetConstants.bismillahDefault, width: 170,),
                                  SizedBox(height: 10,),
                                  Text(
                                    'اَللّٰهُ لَآ اِلٰهَ اِلَّا هُوَۚ اَلْحَيُّ الْقَيُّوْمُ ەۚ لَا تَأْخُذُهٗ سِنَةٌ وَّلَا نَوْمٌۗ  لَهٗ مَا فِى السَّمٰوٰتِ وَمَا فِى الْاَرْضِۗ مَنْ ذَا الَّذِيْ يَشْفَعُ عِنْدَهٗٓ اِلَّا بِاِذْنِهٖۗ يَعْلَمُ مَا بَيْنَ اَيْدِيْهِمْ وَمَا خَلْفَهُمْۚ وَلَا يُحِيْطُوْنَ بِشَيْءٍ مِّنْ عِلْمِهٖٓ اِلَّا بِمَا شَاۤءَۚ وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْاَرْضَۚ وَلَا يَـُٔوْدُهٗ حِفْظُهُمَاۚ وَهُوَ الْعَلِيُّ الْعَظِيْمُ',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Disclosure(
                              wrapper: (state, child) {
                                return Card(
                                  margin: EdgeInsets.zero,
                                  color: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: child,
                                );
                              },
                              header: DisclosureButton(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  title: Text(
                                    'Teks Latin',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: DisclosureIcon(color: Colors.white),
                                ),
                              ),
                              divider: const Divider(height: 1),
                              child: DisclosureView(
                                maxHeight: 200,
                                padding: EdgeInsets.all(24.0),
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "allāhu lā ilāha illā huw(a), al-ḥayyul-qayyūm(u), lā ta'khużuhū sinatuw wa lā naum(un), lahū mā fis-samāwāti wa mā fil-arḍ(i), man żal-lażī yasyfa‘u ‘indahū illā bi'iżnih(ī), ya‘lamu mā baina aidīhim wa mā khalfahum, wa lā yuḥīṭūna bisyai'im min ‘ilmihī illā bimā syā'(a), wasi‘a kursiyyuhus-samāwāti wal-arḍ(a), wa lā ya'ūduhū ḥifẓuhumā, wa huwal-‘aliyyul-‘aẓīm(u).",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Disclosure(
                              wrapper: (state, child) {
                                return Card(
                                  margin: EdgeInsets.zero,
                                  color: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: child,
                                );
                              },
                              header: DisclosureButton(
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  title: Text(
                                    'Terjemahan',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: DisclosureIcon(color: Colors.white),
                                ),
                              ),
                              divider: const Divider(height: 1),
                              child: DisclosureView(
                                maxHeight: 200,
                                padding: EdgeInsets.all(24.0),
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Allah, tidak ada tuhan selain Dia. Yang Mahahidup, Yang terus menerus mengurus (makhluk-Nya), tidak mengantuk dan tidak tidur. Milik-Nya apa yang ada di langit dan apa yang ada di bumi. Tidak ada yang dapat memberi syafaat di sisi-Nya tanpa izin-Nya. Dia mengetahui apa yang di hadapan mereka dan apa yang di belakang mereka, dan mereka tidak mengetahui sesuatu apa pun tentang ilmu-Nya melainkan apa yang Dia kehendaki. Kursi-Nya meliputi langit dan bumi. Dan Dia tidak merasa berat memelihara keduanya, dan Dia Mahatinggi, Mahabesar.',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
