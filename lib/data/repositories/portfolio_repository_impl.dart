import '../../domain/entities/entities.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/local/portfolio_local_datasource_interface.dart';

/// Implementation of the PortfolioRepository.
/// This follows the Repository Pattern, acting as a single source of truth.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource _localDataSource;

  PortfolioRepositoryImpl({
    required PortfolioLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<List<ServiceEntity>> getServices() async {
    return _localDataSource.getServices();
  }

  @override
  Future<List<PortfolioEntity>> getPortfolioItems() async {
    return _localDataSource.getPortfolioItems();
  }

  @override
  Future<List<SocialLinkEntity>> getSocialLinks() async {
    return _localDataSource.getSocialLinks();
  }

  @override
  Future<List<StatEntity>> getStats() async {
    return _localDataSource.getStats();
  }

  @override
  Future<List<NavItemEntity>> getNavItems() async {
    return _localDataSource.getNavItems();
  }

  @override
  Future<ProfileEntity> getProfile() async {
    return _localDataSource.getProfile();
  }

  @override
  Future<List<ExperienceEntity>> getExperiences() async {
    return _localDataSource.getExperiences();
  }

  @override
  Future<List<EducationEntity>> getEducation() async {
    return _localDataSource.getEducation();
  }

  @override
  Future<List<CertificationEntity>> getCertifications() async {
    return _localDataSource.getCertifications();
  }

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    return _localDataSource.getAchievements();
  }

  @override
  Future<List<ExpertiseEntity>> getExpertise() async {
    return _localDataSource.getExpertise();
  }

  @override
  Future<List<ContactInfoEntity>> getContactInfo() async {
    return _localDataSource.getContactInfo();
  }

  @override
  Future<List<ProjectDetailEntity>> getProjectDetails() async {
    return _localDataSource.getProjectDetails();
  }
}
