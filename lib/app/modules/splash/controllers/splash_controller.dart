import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/app/modules/home/bindings/home_binding.dart';
import 'package:quran_kareem/app/modules/home/views/home_view.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;
  
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;
  Animation<double> get fadeAnimation => _fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOut),
    );

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeIn),
    );

    _fadeAnimationController.forward();
    _slideAnimationController.forward();

    HomeBinding().dependencies(); 

    Future.delayed(Duration(seconds: 4), () {
      Get.off(
        () => HomeView(),
        transition: Transition.fade,
        duration: Duration(milliseconds: 1500),
      );
    }).catchError((e) {
      print('Unhandled error: $e');
    });
  }

  @override
  void onClose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.onClose();
  }
}
