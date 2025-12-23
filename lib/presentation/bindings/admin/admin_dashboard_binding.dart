import 'package:get/get.dart';

import '../../../domain/usecases/admin/admin_usecases.dart';
import '../../../domain/usecases/stream/stream_usecases.dart';
import '../../controllers/admin/admin_dashboard_controller.dart';

/// Binding class for Admin Dashboard feature.
class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardController>(
      () => AdminDashboardController(
        // Stream use cases
        watchServicesUseCase: Get.find<WatchServicesUseCase>(),
        watchPortfolioItemsUseCase: Get.find<WatchPortfolioItemsUseCase>(),
        watchExperiencesUseCase: Get.find<WatchExperiencesUseCase>(),
        watchProfileUseCase: Get.find<WatchProfileUseCase>(),
        watchSocialLinksUseCase: Get.find<WatchSocialLinksUseCase>(),
        watchStatsUseCase: Get.find<WatchStatsUseCase>(),
        watchEducationUseCase: Get.find<WatchEducationUseCase>(),
        watchCertificationsUseCase: Get.find<WatchCertificationsUseCase>(),
        watchAchievementsUseCase: Get.find<WatchAchievementsUseCase>(),
        watchExpertiseUseCase: Get.find<WatchExpertiseUseCase>(),
        watchContactInfoUseCase: Get.find<WatchContactInfoUseCase>(),
        watchProjectDetailsUseCase: Get.find<WatchProjectDetailsUseCase>(),
        watchHeroSectionUseCase: Get.find<WatchHeroSectionUseCase>(),
        watchCvUseCase: Get.find<WatchCvUseCase>(),
        // Service CRUD
        addServiceUseCase: Get.find<AddServiceUseCase>(),
        updateServiceUseCase: Get.find<UpdateServiceUseCase>(),
        deleteServiceUseCase: Get.find<DeleteServiceUseCase>(),
        // Portfolio CRUD
        addPortfolioItemUseCase: Get.find<AddPortfolioItemUseCase>(),
        updatePortfolioItemUseCase: Get.find<UpdatePortfolioItemUseCase>(),
        deletePortfolioItemUseCase: Get.find<DeletePortfolioItemUseCase>(),
        // Experience CRUD
        addExperienceUseCase: Get.find<AddExperienceUseCase>(),
        updateExperienceUseCase: Get.find<UpdateExperienceUseCase>(),
        deleteExperienceUseCase: Get.find<DeleteExperienceUseCase>(),
        // Profile
        updateProfileUseCase: Get.find<UpdateProfileUseCase>(),
        // Social Link CRUD
        addSocialLinkUseCase: Get.find<AddSocialLinkUseCase>(),
        updateSocialLinkUseCase: Get.find<UpdateSocialLinkUseCase>(),
        deleteSocialLinkUseCase: Get.find<DeleteSocialLinkUseCase>(),
        // Stat CRUD
        addStatUseCase: Get.find<AddStatUseCase>(),
        updateStatUseCase: Get.find<UpdateStatUseCase>(),
        deleteStatUseCase: Get.find<DeleteStatUseCase>(),
        // Education CRUD
        addEducationUseCase: Get.find<AddEducationUseCase>(),
        updateEducationUseCase: Get.find<UpdateEducationUseCase>(),
        deleteEducationUseCase: Get.find<DeleteEducationUseCase>(),
        // Certification CRUD
        addCertificationUseCase: Get.find<AddCertificationUseCase>(),
        updateCertificationUseCase: Get.find<UpdateCertificationUseCase>(),
        deleteCertificationUseCase: Get.find<DeleteCertificationUseCase>(),
        // Achievement CRUD
        addAchievementUseCase: Get.find<AddAchievementUseCase>(),
        updateAchievementUseCase: Get.find<UpdateAchievementUseCase>(),
        deleteAchievementUseCase: Get.find<DeleteAchievementUseCase>(),
        // Expertise CRUD
        addExpertiseUseCase: Get.find<AddExpertiseUseCase>(),
        updateExpertiseUseCase: Get.find<UpdateExpertiseUseCase>(),
        deleteExpertiseUseCase: Get.find<DeleteExpertiseUseCase>(),
        // Contact Info CRUD
        addContactInfoUseCase: Get.find<AddContactInfoUseCase>(),
        updateContactInfoUseCase: Get.find<UpdateContactInfoUseCase>(),
        deleteContactInfoUseCase: Get.find<DeleteContactInfoUseCase>(),
        // Project Detail CRUD
        addProjectDetailUseCase: Get.find<AddProjectDetailUseCase>(),
        updateProjectDetailUseCase: Get.find<UpdateProjectDetailUseCase>(),
        deleteProjectDetailUseCase: Get.find<DeleteProjectDetailUseCase>(),
        // Seed data
        seedInitialDataUseCase: Get.find<SeedInitialDataUseCase>(),
        // Hero Section
        updateHeroSectionUseCase: Get.find<UpdateHeroSectionUseCase>(),
        // CV
        updateCvUseCase: Get.find<UpdateCvUseCase>(),
      ),
    );
  }
}
