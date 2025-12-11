import '../entities/entities.dart';

/// Abstract repository interface for portfolio data.
/// This defines the contract that data layer must implement.
abstract class PortfolioRepository {
  /// Get all services offered
  Future<List<ServiceEntity>> getServices();

  /// Get all portfolio projects
  Future<List<PortfolioEntity>> getPortfolioItems();

  /// Get all social media links
  Future<List<SocialLinkEntity>> getSocialLinks();

  /// Get statistics/achievements
  Future<List<StatEntity>> getStats();

  /// Get navigation items
  Future<List<NavItemEntity>> getNavItems();

  /// Get profile information
  Future<ProfileEntity> getProfile();

  /// Get work experiences
  Future<List<ExperienceEntity>> getExperiences();

  /// Get education entries
  Future<List<EducationEntity>> getEducation();

  /// Get certifications
  Future<List<CertificationEntity>> getCertifications();

  /// Get achievements
  Future<List<AchievementEntity>> getAchievements();

  /// Get technical expertise categories
  Future<List<ExpertiseEntity>> getExpertise();

  /// Get contact information
  Future<List<ContactInfoEntity>> getContactInfo();

  /// Get detailed projects for Projects page
  Future<List<ProjectDetailEntity>> getProjectDetails();
}
