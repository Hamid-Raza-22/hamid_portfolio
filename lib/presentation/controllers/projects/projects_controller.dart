import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/stream/stream_usecases.dart';

/// Controller for Projects page following MVVM pattern.
/// Uses Firebase real-time streams for live updates.
class ProjectsController extends GetxController {
  final WatchProjectDetailsUseCase _watchProjectDetailsUseCase;

  ProjectsController({
    required WatchProjectDetailsUseCase watchProjectDetailsUseCase,
  }) : _watchProjectDetailsUseCase = watchProjectDetailsUseCase;

  StreamSubscription? _subscription;

  // Observable State
  final isLoading = true.obs;
  final projects = <ProjectDetailEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _subscribeToStream();
  }

  void _subscribeToStream() {
    isLoading.value = true;

    _subscription = _watchProjectDetailsUseCase().listen(
      (data) {
        projects.value = data;
        if (isLoading.value) {
          isLoading.value = false;
        }
      },
      onError: (e) => debugPrint('Error watching projects: $e'),
    );
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
