import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

/// Controller for Projects page following MVVM pattern.
class ProjectsController extends GetxController {
  final GetProjectDetailsUseCase _getProjectDetailsUseCase;

  ProjectsController({
    required GetProjectDetailsUseCase getProjectDetailsUseCase,
  }) : _getProjectDetailsUseCase = getProjectDetailsUseCase;

  // Observable State
  final isLoading = true.obs;
  final projects = <ProjectDetailEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      isLoading.value = true;
      projects.value = await _getProjectDetailsUseCase();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error loading projects data: $e');
    }
  }

  void goBack() => Get.back();
}
