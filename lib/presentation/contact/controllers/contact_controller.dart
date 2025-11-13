import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isSending = false.obs;
  final messageSent = false.obs;

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

  Future<void> sendMessage() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isSending.value = true;
      
      // Simulate sending message (replace with actual API call)
      await Future.delayed(const Duration(seconds: 2));
      
      messageSent.value = true;
      Get.snackbar(
        'Success',
        'Your message has been sent successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
      
      // Clear form
      nameController.clear();
      emailController.clear();
      subjectController.clear();
      messageController.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    fadeController.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
