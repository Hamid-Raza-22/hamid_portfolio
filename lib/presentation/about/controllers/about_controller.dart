import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  
  final currentTab = 0.obs;
  final tabs = ['Story', 'Education', 'Experience'].obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
  }

  void _initAnimations() {
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeOut,
      ),
    );

    fadeController.forward();
  }

  void changeTab(int index) {
    currentTab.value = index;
  }

  @override
  void onClose() {
    fadeController.dispose();
    super.onClose();
  }
}
