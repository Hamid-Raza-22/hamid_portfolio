import '../../domain/entities/entities.dart';
import '../../domain/repositories/portfolio_repository_stream.dart';
import '../datasources/local/portfolio_local_datasource_interface.dart';
import '../datasources/remote/firebase_datasource.dart';
import '../models/models.dart';

/// Implementation of PortfolioRepositoryStream using Firebase.
/// Provides real-time data streams and CRUD operations for admin.
class PortfolioRepositoryStreamImpl implements PortfolioRepositoryStream {
  final FirebaseDataSource _firebaseDataSource;
  final PortfolioLocalDataSource _localDataSource;

  PortfolioRepositoryStreamImpl({
    required FirebaseDataSource firebaseDataSource,
    required PortfolioLocalDataSource localDataSource,
  })  : _firebaseDataSource = firebaseDataSource,
        _localDataSource = localDataSource;

  // ============ STREAM METHODS ============

  @override
  Stream<List<ServiceEntity>> watchServices() {
    return _firebaseDataSource.watchServices();
  }

  @override
  Stream<List<PortfolioEntity>> watchPortfolioItems() {
    return _firebaseDataSource.watchPortfolioItems();
  }

  @override
  Stream<List<SocialLinkEntity>> watchSocialLinks() {
    return _firebaseDataSource.watchSocialLinks();
  }

  @override
  Stream<List<StatEntity>> watchStats() {
    return _firebaseDataSource.watchStats();
  }

  @override
  Stream<List<NavItemEntity>> watchNavItems() {
    return _firebaseDataSource.watchNavItems();
  }

  @override
  Stream<ProfileEntity> watchProfile() {
    return _firebaseDataSource.watchProfile();
  }

  @override
  Stream<List<ExperienceEntity>> watchExperiences() {
    return _firebaseDataSource.watchExperiences();
  }

  @override
  Stream<List<EducationEntity>> watchEducation() {
    return _firebaseDataSource.watchEducation();
  }

  @override
  Stream<List<CertificationEntity>> watchCertifications() {
    return _firebaseDataSource.watchCertifications();
  }

  @override
  Stream<List<AchievementEntity>> watchAchievements() {
    return _firebaseDataSource.watchAchievements();
  }

  @override
  Stream<List<ExpertiseEntity>> watchExpertise() {
    return _firebaseDataSource.watchExpertise();
  }

  @override
  Stream<List<ContactInfoEntity>> watchContactInfo() {
    return _firebaseDataSource.watchContactInfo();
  }

  @override
  Stream<List<ProjectDetailEntity>> watchProjectDetails() {
    return _firebaseDataSource.watchProjectDetails();
  }

  @override
  Stream<HeroSectionEntity> watchHeroSection() {
    return _firebaseDataSource.watchHeroSection();
  }

  // ============ CRUD METHODS ============

  @override
  Future<void> addService(ServiceEntity service) =>
      _firebaseDataSource.addService(service);

  @override
  Future<void> updateService(ServiceEntity service) =>
      _firebaseDataSource.updateService(service);

  @override
  Future<void> deleteService(String id) =>
      _firebaseDataSource.deleteService(id);

  @override
  Future<void> addPortfolioItem(PortfolioEntity item) =>
      _firebaseDataSource.addPortfolioItem(item);

  @override
  Future<void> updatePortfolioItem(PortfolioEntity item) =>
      _firebaseDataSource.updatePortfolioItem(item);

  @override
  Future<void> deletePortfolioItem(String id) =>
      _firebaseDataSource.deletePortfolioItem(id);

  @override
  Future<void> addExperience(ExperienceEntity experience) =>
      _firebaseDataSource.addExperience(experience);

  @override
  Future<void> updateExperience(ExperienceEntity experience) =>
      _firebaseDataSource.updateExperience(experience);

  @override
  Future<void> deleteExperience(String id) =>
      _firebaseDataSource.deleteExperience(id);

  @override
  Future<void> updateProfile(ProfileEntity profile) =>
      _firebaseDataSource.updateProfile(profile);

  @override
  Future<void> addSocialLink(SocialLinkEntity link) =>
      _firebaseDataSource.addSocialLink(link);

  @override
  Future<void> updateSocialLink(SocialLinkEntity link) =>
      _firebaseDataSource.updateSocialLink(link);

  @override
  Future<void> deleteSocialLink(String id) =>
      _firebaseDataSource.deleteSocialLink(id);

  @override
  Future<void> addStat(StatEntity stat) =>
      _firebaseDataSource.addStat(stat);

  @override
  Future<void> updateStat(StatEntity stat) =>
      _firebaseDataSource.updateStat(stat);

  @override
  Future<void> deleteStat(String id) =>
      _firebaseDataSource.deleteStat(id);

  @override
  Future<void> addNavItem(NavItemEntity item) =>
      _firebaseDataSource.addNavItem(item);

  @override
  Future<void> updateNavItem(NavItemEntity item) =>
      _firebaseDataSource.updateNavItem(item);

  @override
  Future<void> deleteNavItem(String id) =>
      _firebaseDataSource.deleteNavItem(id);

  @override
  Future<void> addEducation(EducationEntity education) =>
      _firebaseDataSource.addEducation(education);

  @override
  Future<void> updateEducation(EducationEntity education) =>
      _firebaseDataSource.updateEducation(education);

  @override
  Future<void> deleteEducation(String id) =>
      _firebaseDataSource.deleteEducation(id);

  @override
  Future<void> addCertification(CertificationEntity certification) =>
      _firebaseDataSource.addCertification(certification);

  @override
  Future<void> updateCertification(CertificationEntity certification) =>
      _firebaseDataSource.updateCertification(certification);

  @override
  Future<void> deleteCertification(String id) =>
      _firebaseDataSource.deleteCertification(id);

  @override
  Future<void> addAchievement(AchievementEntity achievement) =>
      _firebaseDataSource.addAchievement(achievement);

  @override
  Future<void> updateAchievement(AchievementEntity achievement) =>
      _firebaseDataSource.updateAchievement(achievement);

  @override
  Future<void> deleteAchievement(String id) =>
      _firebaseDataSource.deleteAchievement(id);

  @override
  Future<void> addExpertise(ExpertiseEntity expertise) =>
      _firebaseDataSource.addExpertise(expertise);

  @override
  Future<void> updateExpertise(ExpertiseEntity expertise) =>
      _firebaseDataSource.updateExpertise(expertise);

  @override
  Future<void> deleteExpertise(String id) =>
      _firebaseDataSource.deleteExpertise(id);

  @override
  Future<void> addContactInfo(ContactInfoEntity info) =>
      _firebaseDataSource.addContactInfo(info);

  @override
  Future<void> updateContactInfo(ContactInfoEntity info) =>
      _firebaseDataSource.updateContactInfo(info);

  @override
  Future<void> deleteContactInfo(String id) =>
      _firebaseDataSource.deleteContactInfo(id);

  @override
  Future<void> addProjectDetail(ProjectDetailEntity project) =>
      _firebaseDataSource.addProjectDetail(project);

  @override
  Future<void> updateProjectDetail(ProjectDetailEntity project) =>
      _firebaseDataSource.updateProjectDetail(project);

  @override
  Future<void> deleteProjectDetail(String id) =>
      _firebaseDataSource.deleteProjectDetail(id);

  @override
  Future<void> updateHeroSection(HeroSectionEntity heroSection) =>
      _firebaseDataSource.updateHeroSection(heroSection);

  // ============ SEED DATA METHOD ============

  @override
  Future<void> seedInitialData() async {
    // Seed services
    for (final service in _localDataSource.getServices()) {
      await _firebaseDataSource.addService(service);
    }

    // Seed portfolio items
    for (final item in _localDataSource.getPortfolioItems()) {
      await _firebaseDataSource.addPortfolioItem(item);
    }

    // Seed social links
    for (final link in _localDataSource.getSocialLinks()) {
      await _firebaseDataSource.addSocialLink(link);
    }

    // Seed stats
    for (final stat in _localDataSource.getStats()) {
      await _firebaseDataSource.addStat(stat);
    }

    // Seed nav items
    for (final item in _localDataSource.getNavItems()) {
      await _firebaseDataSource.addNavItem(item);
    }

    // Seed profile
    await _firebaseDataSource.updateProfile(_localDataSource.getProfile());

    // Seed experiences
    for (final exp in _localDataSource.getExperiences()) {
      await _firebaseDataSource.addExperience(exp);
    }

    // Seed education
    for (final edu in _localDataSource.getEducation()) {
      await _firebaseDataSource.addEducation(edu);
    }

    // Seed certifications
    for (final cert in _localDataSource.getCertifications()) {
      await _firebaseDataSource.addCertification(cert);
    }

    // Seed achievements
    for (final ach in _localDataSource.getAchievements()) {
      await _firebaseDataSource.addAchievement(ach);
    }

    // Seed expertise
    for (final exp in _localDataSource.getExpertise()) {
      await _firebaseDataSource.addExpertise(exp);
    }

    // Seed contact info
    for (final info in _localDataSource.getContactInfo()) {
      await _firebaseDataSource.addContactInfo(info);
    }

    // Seed project details
    for (final project in _localDataSource.getProjectDetails()) {
      await _firebaseDataSource.addProjectDetail(project);
    }
  }
}
