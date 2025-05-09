import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.count,
    required this.gradient,
    required this.arabicTitle,
    required this.latinTitle,
    required this.onPressed,
  });

  final int count;
  final String latinTitle;
  final String arabicTitle;
  final VoidCallback onPressed;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    late final String starCardDecoration;
    switch (count) {
      case 1:
        starCardDecoration = AssetConstants.surahCardStar1;
        break;
      case 2:
        starCardDecoration = AssetConstants.surahCardStar2;
        break;
      case 3:
        starCardDecoration = AssetConstants.surahCardStar3;
        break;
      default:
        starCardDecoration = AssetConstants.surahCardStar4;
        break;
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
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
        child: Stack(
          children: [
            Positioned(
              right: 0,
              left: 0,
              child: Image.asset(starCardDecoration, width: 120),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                AssetConstants.transparentQuranDecoration,
                width: 130,
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    arabicTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    latinTitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Color(0xFF0C2165),
                ),
                child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
