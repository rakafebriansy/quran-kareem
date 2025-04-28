import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;

  @override
  void onInit() {
    super.onInit();
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOut),
    );
    _slideAnimationController.forward();
  }

  @override
  void onClose() {
    _slideAnimationController.dispose();
    super.onClose();
  }
}
