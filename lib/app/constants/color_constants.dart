import 'package:flutter/widgets.dart';

class ColorConstants {
  static Color shapeColor = Color(0xFF65D6FC);
  static Color darkShapeColor = Color(0xFF455EB5);
  static Color darkBanner = Color(0xFF0A2060);
  static LinearGradient cardGradient = LinearGradient(
    colors: [
      ColorConstants.shapeColor.withOpacity(1),
      ColorConstants.darkShapeColor.withOpacity(1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
