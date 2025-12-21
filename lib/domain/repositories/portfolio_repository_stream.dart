import '../entities/entities.dart';

/// Abstract repository interface for portfolio data with real-time streams.
/// Extends the base repository with stream-based methods for Firebase real-time updates.
abstract class PortfolioRepositoryStream {
  // Stream methods for real-time updates
  Stream<List<ServiceEntity>> watchServices();
  Stream<List<PortfolioEntity>> watchPortfolioItems();
  Stream<List<SocialLinkEntity>> watchSocialLinks();
  Stream<List<StatEntity>> watchStats();
  Stream<List<NavItemEntity>> watchNavItems();
  Stream<ProfileEntity> watchProfile();
  Stream<List<ExperienceEntity>> watchExperiences();
  Stream<List<EducationEntity>> watchEducation();
  Stream<List<CertificationEntity>> watchCertifications();
  Stream<List<AchievementEntity>> watchAchievements();
  Stream<List<ExpertiseEntity>> watchExpertise();
  Stream<List<ContactInfoEntity>> watchContactInfo();
  Stream<List<ProjectDetailEntity>> watchProjectDetails();

  // CRUD methods for admin operations
  Future<void> addService(ServiceEntity service);
  Future<void> updateService(ServiceEntity service);
  Future<void> deleteService(String id);

  Future<void> addPortfolioItem(PortfolioEntity item);
  Future<void> updatePortfolioItem(PortfolioEntity item);
  Future<void> deletePortfolioItem(String id);

  Future<void> addExperience(ExperienceEntity experience);
  Future<void> updateExperience(ExperienceEntity experience);
  Future<void> deleteExperience(String id);

  Future<void> updateProfile(ProfileEntity profile);

  Future<void> addSocialLink(SocialLinkEntity link);
  Future<void> updateSocialLink(SocialLinkEntity link);
  Future<void> deleteSocialLink(String id);

  Future<void> addStat(StatEntity stat);
  Future<void> updateStat(StatEntity stat);
  Future<void> deleteStat(String id);

  Future<void> addNavItem(NavItemEntity item);
  Future<void> updateNavItem(NavItemEntity item);
  Future<void> deleteNavItem(String id);

  Future<void> addEducation(EducationEntity education);
  Future<void> updateEducation(EducationEntity education);
  Future<void> deleteEducation(String id);

  Future<void> addCertification(CertificationEntity certification);
  Future<void> updateCertification(CertificationEntity certification);
  Future<void> deleteCertification(String id);

  Future<void> addAchievement(AchievementEntity achievement);
  Future<void> updateAchievement(AchievementEntity achievement);
  Future<void> deleteAchievement(String id);

  Future<void> addExpertise(ExpertiseEntity expertise);
  Future<void> updateExpertise(ExpertiseEntity expertise);
  Future<void> deleteExpertise(String id);

  Future<void> addContactInfo(ContactInfoEntity info);
  Future<void> updateContactInfo(ContactInfoEntity info);
  Future<void> deleteContactInfo(String id);

  Future<void> addProjectDetail(ProjectDetailEntity project);
  Future<void> updateProjectDetail(ProjectDetailEntity project);
  Future<void> deleteProjectDetail(String id);

  // Seed initial data from local source
  Future<void> seedInitialData();
}
