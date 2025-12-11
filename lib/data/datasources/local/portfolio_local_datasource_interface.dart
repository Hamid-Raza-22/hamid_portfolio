import '../../../domain/entities/entities.dart';

/// Abstract interface for portfolio local data source.
/// Defines the contract for local data access operations.
abstract class PortfolioLocalDataSource {
  List<ServiceEntity> getServices();
  List<PortfolioEntity> getPortfolioItems();
  List<SocialLinkEntity> getSocialLinks();
  List<StatEntity> getStats();
  List<NavItemEntity> getNavItems();
  ProfileEntity getProfile();
  List<ExperienceEntity> getExperiences();
  List<EducationEntity> getEducation();
  List<CertificationEntity> getCertifications();
  List<AchievementEntity> getAchievements();
  List<ExpertiseEntity> getExpertise();
  List<ContactInfoEntity> getContactInfo();
  List<ProjectDetailEntity> getProjectDetails();
}
