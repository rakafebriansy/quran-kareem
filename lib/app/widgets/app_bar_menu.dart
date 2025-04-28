import 'package:flutter/material.dart';
import 'package:quran_kareem/app/constants/asset_constants.dart';
import 'package:quran_kareem/app/constants/color_constants.dart';

class AppBarMenu extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarMenu({Key? key})
    : preferredSize = Size.fromHeight(kToolbarHeight),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {},
        child: Icon(Icons.menu, color: ColorConstants.shapeColor, size: 28),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AssetConstants.userDefault),
          ),
        ),
      ],
    );
  }
}
