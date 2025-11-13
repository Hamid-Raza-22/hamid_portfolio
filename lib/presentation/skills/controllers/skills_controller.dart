import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../../data/models/skill_model.dart';

class SkillsController extends GetxController with GetTickerProviderStateMixin {
  final PortfolioRepository _repository = Get.find<PortfolioRepository>();

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  final skills = <SkillModel>[].obs;
  final isLoading = false.obs;
  final selectedCategory = 'All'.obs;
  final categories = <String>['All'].obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _loadSkills();
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

  Future<void> _loadSkills() async {
    try {
      isLoading.value = true;
      final loadedSkills = await _repository.getSkills();
      skills.value = loadedSkills;
      
      // Extract unique categories
      final uniqueCategories = loadedSkills
          .map((skill) => skill.category)
          .toSet()
          .toList();
      categories.value = ['All', ...uniqueCategories];
    } catch (e) {
      debugPrint('Error loading skills: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  List<SkillModel> get filteredSkills {
    if (selectedCategory.value == 'All') {
      return skills;
    }
    return skills.where((skill) => skill.category == selectedCategory.value).toList();
  }

  @override
  void onClose() {
    fadeController.dispose();
    super.onClose();
  }
}
