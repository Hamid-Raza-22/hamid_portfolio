import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../../data/models/project_model.dart';

class ProjectsController extends GetxController with GetTickerProviderStateMixin {
  final PortfolioRepository _repository = Get.find<PortfolioRepository>();

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  final projects = <ProjectModel>[].obs;
  final isLoading = false.obs;
  final selectedCategory = 'All'.obs;
  final categories = <String>['All', 'Mobile', 'Web', 'Desktop'].obs;
  final hoveredProjectId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _loadProjects();
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

  Future<void> _loadProjects() async {
    try {
      isLoading.value = true;
      final loadedProjects = await _repository.getProjects();
      projects.value = loadedProjects;
    } catch (e) {
      debugPrint('Error loading projects: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void setHoveredProject(String projectId) {
    hoveredProjectId.value = projectId;
  }

  List<ProjectModel> get filteredProjects {
    if (selectedCategory.value == 'All') {
      return projects;
    }
    return projects.where((project) => project.category == selectedCategory.value).toList();
  }

  @override
  void onClose() {
    fadeController.dispose();
    super.onClose();
  }
}
