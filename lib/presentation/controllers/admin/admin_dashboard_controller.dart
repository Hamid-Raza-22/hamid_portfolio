import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/admin/admin_usecases.dart';
import '../../../domain/usecases/stream/stream_usecases.dart';

/// Admin Dashboard Controller for managing all portfolio sections.
class AdminDashboardController extends GetxController {
  // Stream use cases
  final WatchServicesUseCase _watchServicesUseCase;
  final WatchPortfolioItemsUseCase _watchPortfolioItemsUseCase;
  final WatchExperiencesUseCase _watchExperiencesUseCase;
  final WatchProfileUseCase _watchProfileUseCase;
  final WatchSocialLinksUseCase _watchSocialLinksUseCase;
  final WatchStatsUseCase _watchStatsUseCase;
  final WatchEducationUseCase _watchEducationUseCase;
  final WatchCertificationsUseCase _watchCertificationsUseCase;
  final WatchAchievementsUseCase _watchAchievementsUseCase;
  final WatchExpertiseUseCase _watchExpertiseUseCase;
  final WatchContactInfoUseCase _watchContactInfoUseCase;
  final WatchProjectDetailsUseCase _watchProjectDetailsUseCase;
  final WatchHeroSectionUseCase _watchHeroSectionUseCase;

  // Admin CRUD use cases
  final AddServiceUseCase _addServiceUseCase;
  final UpdateServiceUseCase _updateServiceUseCase;
  final DeleteServiceUseCase _deleteServiceUseCase;

  final AddPortfolioItemUseCase _addPortfolioItemUseCase;
  final UpdatePortfolioItemUseCase _updatePortfolioItemUseCase;
  final DeletePortfolioItemUseCase _deletePortfolioItemUseCase;

  final AddExperienceUseCase _addExperienceUseCase;
  final UpdateExperienceUseCase _updateExperienceUseCase;
  final DeleteExperienceUseCase _deleteExperienceUseCase;

  final UpdateProfileUseCase _updateProfileUseCase;

  final AddSocialLinkUseCase _addSocialLinkUseCase;
  final UpdateSocialLinkUseCase _updateSocialLinkUseCase;
  final DeleteSocialLinkUseCase _deleteSocialLinkUseCase;

  final AddStatUseCase _addStatUseCase;
  final UpdateStatUseCase _updateStatUseCase;
  final DeleteStatUseCase _deleteStatUseCase;

  final AddEducationUseCase _addEducationUseCase;
  final UpdateEducationUseCase _updateEducationUseCase;
  final DeleteEducationUseCase _deleteEducationUseCase;

  final AddCertificationUseCase _addCertificationUseCase;
  final UpdateCertificationUseCase _updateCertificationUseCase;
  final DeleteCertificationUseCase _deleteCertificationUseCase;

  final AddAchievementUseCase _addAchievementUseCase;
  final UpdateAchievementUseCase _updateAchievementUseCase;
  final DeleteAchievementUseCase _deleteAchievementUseCase;

  final AddExpertiseUseCase _addExpertiseUseCase;
  final UpdateExpertiseUseCase _updateExpertiseUseCase;
  final DeleteExpertiseUseCase _deleteExpertiseUseCase;

  final AddContactInfoUseCase _addContactInfoUseCase;
  final UpdateContactInfoUseCase _updateContactInfoUseCase;
  final DeleteContactInfoUseCase _deleteContactInfoUseCase;

  final AddProjectDetailUseCase _addProjectDetailUseCase;
  final UpdateProjectDetailUseCase _updateProjectDetailUseCase;
  final DeleteProjectDetailUseCase _deleteProjectDetailUseCase;

  final SeedInitialDataUseCase _seedInitialDataUseCase;
  final UpdateHeroSectionUseCase _updateHeroSectionUseCase;

  AdminDashboardController({
    required WatchServicesUseCase watchServicesUseCase,
    required WatchPortfolioItemsUseCase watchPortfolioItemsUseCase,
    required WatchExperiencesUseCase watchExperiencesUseCase,
    required WatchProfileUseCase watchProfileUseCase,
    required WatchSocialLinksUseCase watchSocialLinksUseCase,
    required WatchStatsUseCase watchStatsUseCase,
    required WatchEducationUseCase watchEducationUseCase,
    required WatchCertificationsUseCase watchCertificationsUseCase,
    required WatchAchievementsUseCase watchAchievementsUseCase,
    required WatchExpertiseUseCase watchExpertiseUseCase,
    required WatchContactInfoUseCase watchContactInfoUseCase,
    required WatchProjectDetailsUseCase watchProjectDetailsUseCase,
    required WatchHeroSectionUseCase watchHeroSectionUseCase,
    required AddServiceUseCase addServiceUseCase,
    required UpdateServiceUseCase updateServiceUseCase,
    required DeleteServiceUseCase deleteServiceUseCase,
    required AddPortfolioItemUseCase addPortfolioItemUseCase,
    required UpdatePortfolioItemUseCase updatePortfolioItemUseCase,
    required DeletePortfolioItemUseCase deletePortfolioItemUseCase,
    required AddExperienceUseCase addExperienceUseCase,
    required UpdateExperienceUseCase updateExperienceUseCase,
    required DeleteExperienceUseCase deleteExperienceUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required AddSocialLinkUseCase addSocialLinkUseCase,
    required UpdateSocialLinkUseCase updateSocialLinkUseCase,
    required DeleteSocialLinkUseCase deleteSocialLinkUseCase,
    required AddStatUseCase addStatUseCase,
    required UpdateStatUseCase updateStatUseCase,
    required DeleteStatUseCase deleteStatUseCase,
    required AddEducationUseCase addEducationUseCase,
    required UpdateEducationUseCase updateEducationUseCase,
    required DeleteEducationUseCase deleteEducationUseCase,
    required AddCertificationUseCase addCertificationUseCase,
    required UpdateCertificationUseCase updateCertificationUseCase,
    required DeleteCertificationUseCase deleteCertificationUseCase,
    required AddAchievementUseCase addAchievementUseCase,
    required UpdateAchievementUseCase updateAchievementUseCase,
    required DeleteAchievementUseCase deleteAchievementUseCase,
    required AddExpertiseUseCase addExpertiseUseCase,
    required UpdateExpertiseUseCase updateExpertiseUseCase,
    required DeleteExpertiseUseCase deleteExpertiseUseCase,
    required AddContactInfoUseCase addContactInfoUseCase,
    required UpdateContactInfoUseCase updateContactInfoUseCase,
    required DeleteContactInfoUseCase deleteContactInfoUseCase,
    required AddProjectDetailUseCase addProjectDetailUseCase,
    required UpdateProjectDetailUseCase updateProjectDetailUseCase,
    required DeleteProjectDetailUseCase deleteProjectDetailUseCase,
    required SeedInitialDataUseCase seedInitialDataUseCase,
    required UpdateHeroSectionUseCase updateHeroSectionUseCase,
  })  : _watchServicesUseCase = watchServicesUseCase,
        _watchPortfolioItemsUseCase = watchPortfolioItemsUseCase,
        _watchExperiencesUseCase = watchExperiencesUseCase,
        _watchProfileUseCase = watchProfileUseCase,
        _watchSocialLinksUseCase = watchSocialLinksUseCase,
        _watchStatsUseCase = watchStatsUseCase,
        _watchEducationUseCase = watchEducationUseCase,
        _watchCertificationsUseCase = watchCertificationsUseCase,
        _watchAchievementsUseCase = watchAchievementsUseCase,
        _watchExpertiseUseCase = watchExpertiseUseCase,
        _watchContactInfoUseCase = watchContactInfoUseCase,
        _watchProjectDetailsUseCase = watchProjectDetailsUseCase,
        _watchHeroSectionUseCase = watchHeroSectionUseCase,
        _addServiceUseCase = addServiceUseCase,
        _updateServiceUseCase = updateServiceUseCase,
        _deleteServiceUseCase = deleteServiceUseCase,
        _addPortfolioItemUseCase = addPortfolioItemUseCase,
        _updatePortfolioItemUseCase = updatePortfolioItemUseCase,
        _deletePortfolioItemUseCase = deletePortfolioItemUseCase,
        _addExperienceUseCase = addExperienceUseCase,
        _updateExperienceUseCase = updateExperienceUseCase,
        _deleteExperienceUseCase = deleteExperienceUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _addSocialLinkUseCase = addSocialLinkUseCase,
        _updateSocialLinkUseCase = updateSocialLinkUseCase,
        _deleteSocialLinkUseCase = deleteSocialLinkUseCase,
        _addStatUseCase = addStatUseCase,
        _updateStatUseCase = updateStatUseCase,
        _deleteStatUseCase = deleteStatUseCase,
        _addEducationUseCase = addEducationUseCase,
        _updateEducationUseCase = updateEducationUseCase,
        _deleteEducationUseCase = deleteEducationUseCase,
        _addCertificationUseCase = addCertificationUseCase,
        _updateCertificationUseCase = updateCertificationUseCase,
        _deleteCertificationUseCase = deleteCertificationUseCase,
        _addAchievementUseCase = addAchievementUseCase,
        _updateAchievementUseCase = updateAchievementUseCase,
        _deleteAchievementUseCase = deleteAchievementUseCase,
        _addExpertiseUseCase = addExpertiseUseCase,
        _updateExpertiseUseCase = updateExpertiseUseCase,
        _deleteExpertiseUseCase = deleteExpertiseUseCase,
        _addContactInfoUseCase = addContactInfoUseCase,
        _updateContactInfoUseCase = updateContactInfoUseCase,
        _deleteContactInfoUseCase = deleteContactInfoUseCase,
        _addProjectDetailUseCase = addProjectDetailUseCase,
        _updateProjectDetailUseCase = updateProjectDetailUseCase,
        _deleteProjectDetailUseCase = deleteProjectDetailUseCase,
        _seedInitialDataUseCase = seedInitialDataUseCase,
        _updateHeroSectionUseCase = updateHeroSectionUseCase;

  // UUID generator
  final _uuid = const Uuid();

  // Observable state
  final selectedCategory = 0.obs;
  final isLoading = false.obs;
  final isSeedingData = false.obs;

  // Data streams
  final services = <ServiceEntity>[].obs;
  final portfolioItems = <PortfolioEntity>[].obs;
  final experiences = <ExperienceEntity>[].obs;
  final profile = Rxn<ProfileEntity>();
  final socialLinks = <SocialLinkEntity>[].obs;
  final stats = <StatEntity>[].obs;
  final education = <EducationEntity>[].obs;
  final certifications = <CertificationEntity>[].obs;
  final achievements = <AchievementEntity>[].obs;
  final expertise = <ExpertiseEntity>[].obs;
  final contactInfo = <ContactInfoEntity>[].obs;
  final projectDetails = <ProjectDetailEntity>[].obs;
  final heroSection = Rxn<HeroSectionEntity>();

  // Stream subscriptions
  final List<StreamSubscription> _subscriptions = [];

  // Categories for navigation
  final List<Map<String, dynamic>> categories = [
    {'title': 'Hero Section', 'icon': Icons.home},
    {'title': 'Profile', 'icon': Icons.person},
    {'title': 'Services', 'icon': Icons.design_services},
    {'title': 'Portfolio', 'icon': Icons.work},
    {'title': 'Projects', 'icon': Icons.folder},
    {'title': 'Experience', 'icon': Icons.business},
    {'title': 'Education', 'icon': Icons.school},
    {'title': 'Certifications', 'icon': Icons.workspace_premium},
    {'title': 'Skills', 'icon': Icons.code},
    {'title': 'Achievements', 'icon': Icons.emoji_events},
    {'title': 'Contact', 'icon': Icons.contact_mail},
    {'title': 'Social Links', 'icon': Icons.share},
    {'title': 'Stats', 'icon': Icons.analytics},
  ];

  @override
  void onInit() {
    super.onInit();
    _subscribeToStreams();
  }

  void _subscribeToStreams() {
    _subscriptions.addAll([
      _watchServicesUseCase().listen((data) => services.value = data),
      _watchPortfolioItemsUseCase().listen((data) => portfolioItems.value = data),
      _watchExperiencesUseCase().listen((data) => experiences.value = data),
      _watchProfileUseCase().listen((data) => profile.value = data),
      _watchSocialLinksUseCase().listen((data) => socialLinks.value = data),
      _watchStatsUseCase().listen((data) => stats.value = data),
      _watchEducationUseCase().listen((data) => education.value = data),
      _watchCertificationsUseCase().listen((data) => certifications.value = data),
      _watchAchievementsUseCase().listen((data) => achievements.value = data),
      _watchExpertiseUseCase().listen((data) => expertise.value = data),
      _watchContactInfoUseCase().listen((data) => contactInfo.value = data),
      _watchProjectDetailsUseCase().listen((data) => projectDetails.value = data),
      _watchHeroSectionUseCase().listen((data) => heroSection.value = data),
    ]);
  }

  void selectCategory(int index) {
    selectedCategory.value = index;
  }

  String generateId() => _uuid.v4();

  // ============ SERVICE CRUD ============
  Future<void> addService(ServiceEntity service) async {
    try {
      isLoading.value = true;
      await _addServiceUseCase(service);
      _showSuccess('Service added successfully');
    } catch (e) {
      _showError('Failed to add service');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateService(ServiceEntity service) async {
    try {
      isLoading.value = true;
      await _updateServiceUseCase(service);
      _showSuccess('Service updated successfully');
    } catch (e) {
      _showError('Failed to update service');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteService(String id) async {
    try {
      isLoading.value = true;
      await _deleteServiceUseCase(id);
      _showSuccess('Service deleted successfully');
    } catch (e) {
      _showError('Failed to delete service');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ PORTFOLIO CRUD ============
  Future<void> addPortfolioItem(PortfolioEntity item) async {
    try {
      isLoading.value = true;
      await _addPortfolioItemUseCase(item);
      _showSuccess('Portfolio item added successfully');
    } catch (e) {
      _showError('Failed to add portfolio item');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePortfolioItem(PortfolioEntity item) async {
    try {
      isLoading.value = true;
      await _updatePortfolioItemUseCase(item);
      _showSuccess('Portfolio item updated successfully');
    } catch (e) {
      _showError('Failed to update portfolio item');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePortfolioItem(String id) async {
    try {
      isLoading.value = true;
      await _deletePortfolioItemUseCase(id);
      _showSuccess('Portfolio item deleted successfully');
    } catch (e) {
      _showError('Failed to delete portfolio item');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ EXPERIENCE CRUD ============
  Future<void> addExperience(ExperienceEntity experience) async {
    try {
      isLoading.value = true;
      await _addExperienceUseCase(experience);
      _showSuccess('Experience added successfully');
    } catch (e) {
      _showError('Failed to add experience');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateExperience(ExperienceEntity experience) async {
    try {
      isLoading.value = true;
      await _updateExperienceUseCase(experience);
      _showSuccess('Experience updated successfully');
    } catch (e) {
      _showError('Failed to update experience');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExperience(String id) async {
    try {
      isLoading.value = true;
      await _deleteExperienceUseCase(id);
      _showSuccess('Experience deleted successfully');
    } catch (e) {
      _showError('Failed to delete experience');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ PROFILE UPDATE ============
  Future<void> updateProfile(ProfileEntity profileData) async {
    try {
      isLoading.value = true;
      await _updateProfileUseCase(profileData);
      _showSuccess('Profile updated successfully');
    } catch (e) {
      _showError('Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ SOCIAL LINK CRUD ============
  Future<void> addSocialLink(SocialLinkEntity link) async {
    try {
      isLoading.value = true;
      await _addSocialLinkUseCase(link);
      _showSuccess('Social link added successfully');
    } catch (e) {
      _showError('Failed to add social link');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSocialLink(SocialLinkEntity link) async {
    try {
      isLoading.value = true;
      await _updateSocialLinkUseCase(link);
      _showSuccess('Social link updated successfully');
    } catch (e) {
      _showError('Failed to update social link');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSocialLink(String id) async {
    try {
      isLoading.value = true;
      await _deleteSocialLinkUseCase(id);
      _showSuccess('Social link deleted successfully');
    } catch (e) {
      _showError('Failed to delete social link');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ STAT CRUD ============
  Future<void> addStat(StatEntity stat) async {
    try {
      isLoading.value = true;
      await _addStatUseCase(stat);
      _showSuccess('Stat added successfully');
    } catch (e) {
      _showError('Failed to add stat');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStat(StatEntity stat) async {
    try {
      isLoading.value = true;
      await _updateStatUseCase(stat);
      _showSuccess('Stat updated successfully');
    } catch (e) {
      _showError('Failed to update stat');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteStat(String id) async {
    try {
      isLoading.value = true;
      await _deleteStatUseCase(id);
      _showSuccess('Stat deleted successfully');
    } catch (e) {
      _showError('Failed to delete stat');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ EDUCATION CRUD ============
  Future<void> addEducation(EducationEntity edu) async {
    try {
      isLoading.value = true;
      await _addEducationUseCase(edu);
      _showSuccess('Education added successfully');
    } catch (e) {
      _showError('Failed to add education');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEducation(EducationEntity edu) async {
    try {
      isLoading.value = true;
      await _updateEducationUseCase(edu);
      _showSuccess('Education updated successfully');
    } catch (e) {
      _showError('Failed to update education');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEducation(String id) async {
    try {
      isLoading.value = true;
      await _deleteEducationUseCase(id);
      _showSuccess('Education deleted successfully');
    } catch (e) {
      _showError('Failed to delete education');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ CERTIFICATION CRUD ============
  Future<void> addCertification(CertificationEntity cert) async {
    try {
      isLoading.value = true;
      await _addCertificationUseCase(cert);
      _showSuccess('Certification added successfully');
    } catch (e) {
      _showError('Failed to add certification');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCertification(CertificationEntity cert) async {
    try {
      isLoading.value = true;
      await _updateCertificationUseCase(cert);
      _showSuccess('Certification updated successfully');
    } catch (e) {
      _showError('Failed to update certification');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCertification(String id) async {
    try {
      isLoading.value = true;
      await _deleteCertificationUseCase(id);
      _showSuccess('Certification deleted successfully');
    } catch (e) {
      _showError('Failed to delete certification');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ ACHIEVEMENT CRUD ============
  Future<void> addAchievement(AchievementEntity achievement) async {
    try {
      isLoading.value = true;
      await _addAchievementUseCase(achievement);
      _showSuccess('Achievement added successfully');
    } catch (e) {
      _showError('Failed to add achievement');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAchievement(AchievementEntity achievement) async {
    try {
      isLoading.value = true;
      await _updateAchievementUseCase(achievement);
      _showSuccess('Achievement updated successfully');
    } catch (e) {
      _showError('Failed to update achievement');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAchievement(String id) async {
    try {
      isLoading.value = true;
      await _deleteAchievementUseCase(id);
      _showSuccess('Achievement deleted successfully');
    } catch (e) {
      _showError('Failed to delete achievement');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ EXPERTISE CRUD ============
  Future<void> addExpertise(ExpertiseEntity exp) async {
    try {
      isLoading.value = true;
      await _addExpertiseUseCase(exp);
      _showSuccess('Expertise added successfully');
    } catch (e) {
      _showError('Failed to add expertise');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateExpertise(ExpertiseEntity exp) async {
    try {
      isLoading.value = true;
      await _updateExpertiseUseCase(exp);
      _showSuccess('Expertise updated successfully');
    } catch (e) {
      _showError('Failed to update expertise');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExpertise(String id) async {
    try {
      isLoading.value = true;
      await _deleteExpertiseUseCase(id);
      _showSuccess('Expertise deleted successfully');
    } catch (e) {
      _showError('Failed to delete expertise');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ CONTACT INFO CRUD ============
  Future<void> addContactInfo(ContactInfoEntity info) async {
    try {
      isLoading.value = true;
      await _addContactInfoUseCase(info);
      _showSuccess('Contact info added successfully');
    } catch (e) {
      _showError('Failed to add contact info');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateContactInfo(ContactInfoEntity info) async {
    try {
      isLoading.value = true;
      await _updateContactInfoUseCase(info);
      _showSuccess('Contact info updated successfully');
    } catch (e) {
      _showError('Failed to update contact info');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteContactInfo(String id) async {
    try {
      isLoading.value = true;
      await _deleteContactInfoUseCase(id);
      _showSuccess('Contact info deleted successfully');
    } catch (e) {
      _showError('Failed to delete contact info');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ PROJECT DETAIL CRUD ============
  Future<void> addProjectDetail(ProjectDetailEntity project) async {
    try {
      isLoading.value = true;
      await _addProjectDetailUseCase(project);
      _showSuccess('Project added successfully');
    } catch (e) {
      _showError('Failed to add project');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProjectDetail(ProjectDetailEntity project) async {
    try {
      isLoading.value = true;
      await _updateProjectDetailUseCase(project);
      _showSuccess('Project updated successfully');
    } catch (e) {
      _showError('Failed to update project');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProjectDetail(String id) async {
    try {
      isLoading.value = true;
      await _deleteProjectDetailUseCase(id);
      _showSuccess('Project deleted successfully');
    } catch (e) {
      _showError('Failed to delete project');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ HERO SECTION UPDATE ============
  Future<void> updateHeroSection(HeroSectionEntity hero) async {
    try {
      isLoading.value = true;
      await _updateHeroSectionUseCase(hero);
      _showSuccess('Hero section updated successfully');
    } catch (e) {
      _showError('Failed to update hero section');
    } finally {
      isLoading.value = false;
    }
  }

  // ============ SEED DATA ============
  Future<void> seedInitialData() async {
    try {
      isSeedingData.value = true;
      await _seedInitialDataUseCase();
      _showSuccess('Initial data seeded successfully');
    } catch (e) {
      _showError('Failed to seed initial data: $e');
    } finally {
      isSeedingData.value = false;
    }
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.onClose();
  }
}
