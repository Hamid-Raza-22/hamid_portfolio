import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

/// Controller for About page following MVVM pattern.
class AboutController extends GetxController {
  final GetProfileUseCase _getProfileUseCase;
  final GetExperiencesUseCase _getExperiencesUseCase;
  final GetEducationUseCase _getEducationUseCase;
  final GetCertificationsUseCase _getCertificationsUseCase;
  final GetAchievementsUseCase _getAchievementsUseCase;
  final GetExpertiseUseCase _getExpertiseUseCase;

  AboutController({
    required GetProfileUseCase getProfileUseCase,
    required GetExperiencesUseCase getExperiencesUseCase,
    required GetEducationUseCase getEducationUseCase,
    required GetCertificationsUseCase getCertificationsUseCase,
    required GetAchievementsUseCase getAchievementsUseCase,
    required GetExpertiseUseCase getExpertiseUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _getExperiencesUseCase = getExperiencesUseCase,
        _getEducationUseCase = getEducationUseCase,
        _getCertificationsUseCase = getCertificationsUseCase,
        _getAchievementsUseCase = getAchievementsUseCase,
        _getExpertiseUseCase = getExpertiseUseCase;

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
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      isLoading.value = true;

      final results = await Future.wait([
        _getProfileUseCase(),
        _getExperiencesUseCase(),
        _getEducationUseCase(),
        _getCertificationsUseCase(),
        _getAchievementsUseCase(),
        _getExpertiseUseCase(),
      ]);

      profile.value = results[0] as ProfileEntity;
      experiences.value = results[1] as List<ExperienceEntity>;
      education.value = results[2] as List<EducationEntity>;
      certifications.value = results[3] as List<CertificationEntity>;
      achievements.value = results[4] as List<AchievementEntity>;
      expertise.value = results[5] as List<ExpertiseEntity>;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error loading about data: $e');
    }
  }

  void goBack() => Get.back();
}
