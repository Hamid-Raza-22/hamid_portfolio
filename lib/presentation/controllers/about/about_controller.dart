import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/stream/stream_usecases.dart';

/// Controller for About page following MVVM pattern.
/// Uses Firebase real-time streams for live updates.
class AboutController extends GetxController {
  final WatchProfileUseCase _watchProfileUseCase;
  final WatchExperiencesUseCase _watchExperiencesUseCase;
  final WatchEducationUseCase _watchEducationUseCase;
  final WatchCertificationsUseCase _watchCertificationsUseCase;
  final WatchAchievementsUseCase _watchAchievementsUseCase;
  final WatchExpertiseUseCase _watchExpertiseUseCase;

  AboutController({
    required WatchProfileUseCase watchProfileUseCase,
    required WatchExperiencesUseCase watchExperiencesUseCase,
    required WatchEducationUseCase watchEducationUseCase,
    required WatchCertificationsUseCase watchCertificationsUseCase,
    required WatchAchievementsUseCase watchAchievementsUseCase,
    required WatchExpertiseUseCase watchExpertiseUseCase,
  })  : _watchProfileUseCase = watchProfileUseCase,
        _watchExperiencesUseCase = watchExperiencesUseCase,
        _watchEducationUseCase = watchEducationUseCase,
        _watchCertificationsUseCase = watchCertificationsUseCase,
        _watchAchievementsUseCase = watchAchievementsUseCase,
        _watchExpertiseUseCase = watchExpertiseUseCase;

  final List<StreamSubscription> _subscriptions = [];

  // Observable State
  final isLoading = true.obs;
  final profile = Rxn<ProfileEntity>();
  final experiences = <ExperienceEntity>[].obs;
  final education = <EducationEntity>[].obs;
  final certifications = <CertificationEntity>[].obs;
  final achievements = <AchievementEntity>[].obs;
  final expertise = <ExpertiseEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _subscribeToStreams();
  }

  void _subscribeToStreams() {
    isLoading.value = true;

    _subscriptions.addAll([
      _watchProfileUseCase().listen(
        (data) {
          profile.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching profile: $e'),
      ),
      _watchExperiencesUseCase().listen(
        (data) {
          experiences.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching experiences: $e'),
      ),
      _watchEducationUseCase().listen(
        (data) {
          education.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching education: $e'),
      ),
      _watchCertificationsUseCase().listen(
        (data) {
          certifications.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching certifications: $e'),
      ),
      _watchAchievementsUseCase().listen(
        (data) {
          achievements.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching achievements: $e'),
      ),
      _watchExpertiseUseCase().listen(
        (data) {
          expertise.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching expertise: $e'),
      ),
    ]);
  }

  void _checkLoadingComplete() {
    if (isLoading.value) {
      isLoading.value = false;
    }
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.onClose();
  }
}
