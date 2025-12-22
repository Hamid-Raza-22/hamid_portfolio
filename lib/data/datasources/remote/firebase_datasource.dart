import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/entities.dart';
import '../../models/models.dart';

/// Firebase remote data source interface.
/// Defines contract for Firebase Firestore operations with real-time streams.
abstract class FirebaseDataSource {
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
  Stream<HeroSectionEntity> watchHeroSection();

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

  Future<void> updateHeroSection(HeroSectionEntity heroSection);

  // Seed data method
  Future<void> seedInitialData();
}

/// Implementation of FirebaseDataSource using Cloud Firestore.
class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseFirestore _firestore;

  // Collection names
  static const String _servicesCollection = 'services';
  static const String _portfolioCollection = 'portfolio';
  static const String _socialLinksCollection = 'socialLinks';
  static const String _statsCollection = 'stats';
  static const String _navItemsCollection = 'navItems';
  static const String _profileCollection = 'profile';
  static const String _experiencesCollection = 'experiences';
  static const String _educationCollection = 'education';
  static const String _certificationsCollection = 'certifications';
  static const String _achievementsCollection = 'achievements';
  static const String _expertiseCollection = 'expertise';
  static const String _contactInfoCollection = 'contactInfo';
  static const String _projectDetailsCollection = 'projectDetails';
  static const String _heroSectionCollection = 'heroSection';

  FirebaseDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ============ STREAM METHODS (Real-time Updates) ============

  @override
  Stream<List<ServiceEntity>> watchServices() {
    return _firestore.collection(_servicesCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ServiceModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<PortfolioEntity>> watchPortfolioItems() {
    return _firestore.collection(_portfolioCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => PortfolioModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<SocialLinkEntity>> watchSocialLinks() {
    return _firestore.collection(_socialLinksCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => SocialLinkModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<StatEntity>> watchStats() {
    return _firestore.collection(_statsCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => StatModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<NavItemEntity>> watchNavItems() {
    return _firestore.collection(_navItemsCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => NavItemModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<ProfileEntity> watchProfile() {
    return _firestore
        .collection(_profileCollection)
        .doc('main')
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        return ProfileModel.fromJson(doc.data()!);
      }
      return const ProfileEntity(
        name: '',
        title: '',
        experience: '',
        summary: '',
        workPreferences: '',
        location: '',
        languages: '',
      );
    });
  }

  @override
  Stream<List<ExperienceEntity>> watchExperiences() {
    return _firestore.collection(_experiencesCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ExperienceModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<EducationEntity>> watchEducation() {
    return _firestore.collection(_educationCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => EducationModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<CertificationEntity>> watchCertifications() {
    return _firestore.collection(_certificationsCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => CertificationModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<AchievementEntity>> watchAchievements() {
    return _firestore.collection(_achievementsCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => AchievementModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<ExpertiseEntity>> watchExpertise() {
    return _firestore.collection(_expertiseCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ExpertiseModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<ContactInfoEntity>> watchContactInfo() {
    return _firestore.collection(_contactInfoCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ContactInfoModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<List<ProjectDetailEntity>> watchProjectDetails() {
    return _firestore.collection(_projectDetailsCollection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ProjectDetailModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Stream<HeroSectionEntity> watchHeroSection() {
    return _firestore
        .collection(_heroSectionCollection)
        .doc('main')
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        return HeroSectionModel.fromJson(doc.data()!, doc.id);
      }
      return const HeroSectionEntity(
        id: 'main',
        greeting: "Hello, I'm",
        name: 'Hamid Raza',
        title: 'Flutter Developer',
        subtitle: 'Mobile & Web Applications',
        description: 'Passionate about creating beautiful, functional applications',
        ctaButtonText: 'Get In Touch',
        ctaButtonLink: '/contact',
      );
    });
  }

  // ============ CRUD METHODS (Admin Operations) ============

  // Services
  @override
  Future<void> addService(ServiceEntity service) async {
    final model = ServiceModel.fromEntity(service);
    await _firestore.collection(_servicesCollection).doc(service.id).set(model.toJson());
  }

  @override
  Future<void> updateService(ServiceEntity service) async {
    final model = ServiceModel.fromEntity(service);
    await _firestore.collection(_servicesCollection).doc(service.id).update(model.toJson());
  }

  @override
  Future<void> deleteService(String id) async {
    await _firestore.collection(_servicesCollection).doc(id).delete();
  }

  // Portfolio
  @override
  Future<void> addPortfolioItem(PortfolioEntity item) async {
    final model = PortfolioModel.fromEntity(item);
    await _firestore.collection(_portfolioCollection).doc(item.id).set(model.toJson());
  }

  @override
  Future<void> updatePortfolioItem(PortfolioEntity item) async {
    final model = PortfolioModel.fromEntity(item);
    await _firestore.collection(_portfolioCollection).doc(item.id).update(model.toJson());
  }

  @override
  Future<void> deletePortfolioItem(String id) async {
    await _firestore.collection(_portfolioCollection).doc(id).delete();
  }

  // Experience
  @override
  Future<void> addExperience(ExperienceEntity experience) async {
    final model = ExperienceModel.fromEntity(experience);
    await _firestore.collection(_experiencesCollection).doc(experience.id).set(model.toJson());
  }

  @override
  Future<void> updateExperience(ExperienceEntity experience) async {
    final model = ExperienceModel.fromEntity(experience);
    await _firestore.collection(_experiencesCollection).doc(experience.id).update(model.toJson());
  }

  @override
  Future<void> deleteExperience(String id) async {
    await _firestore.collection(_experiencesCollection).doc(id).delete();
  }

  // Profile
  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    final model = ProfileModel.fromEntity(profile);
    await _firestore.collection(_profileCollection).doc('main').set(model.toJson());
  }

  // Social Links
  @override
  Future<void> addSocialLink(SocialLinkEntity link) async {
    final model = SocialLinkModel.fromEntity(link);
    await _firestore.collection(_socialLinksCollection).doc(link.id).set(model.toJson());
  }

  @override
  Future<void> updateSocialLink(SocialLinkEntity link) async {
    final model = SocialLinkModel.fromEntity(link);
    await _firestore.collection(_socialLinksCollection).doc(link.id).update(model.toJson());
  }

  @override
  Future<void> deleteSocialLink(String id) async {
    await _firestore.collection(_socialLinksCollection).doc(id).delete();
  }

  // Stats
  @override
  Future<void> addStat(StatEntity stat) async {
    final model = StatModel.fromEntity(stat);
    await _firestore.collection(_statsCollection).doc(stat.id).set(model.toJson());
  }

  @override
  Future<void> updateStat(StatEntity stat) async {
    final model = StatModel.fromEntity(stat);
    await _firestore.collection(_statsCollection).doc(stat.id).update(model.toJson());
  }

  @override
  Future<void> deleteStat(String id) async {
    await _firestore.collection(_statsCollection).doc(id).delete();
  }

  // Nav Items
  @override
  Future<void> addNavItem(NavItemEntity item) async {
    final model = NavItemModel.fromEntity(item);
    await _firestore.collection(_navItemsCollection).doc(item.id).set(model.toJson());
  }

  @override
  Future<void> updateNavItem(NavItemEntity item) async {
    final model = NavItemModel.fromEntity(item);
    await _firestore.collection(_navItemsCollection).doc(item.id).update(model.toJson());
  }

  @override
  Future<void> deleteNavItem(String id) async {
    await _firestore.collection(_navItemsCollection).doc(id).delete();
  }

  // Education
  @override
  Future<void> addEducation(EducationEntity education) async {
    final model = EducationModel.fromEntity(education);
    await _firestore.collection(_educationCollection).doc(education.id).set(model.toJson());
  }

  @override
  Future<void> updateEducation(EducationEntity education) async {
    final model = EducationModel.fromEntity(education);
    await _firestore.collection(_educationCollection).doc(education.id).update(model.toJson());
  }

  @override
  Future<void> deleteEducation(String id) async {
    await _firestore.collection(_educationCollection).doc(id).delete();
  }

  // Certifications
  @override
  Future<void> addCertification(CertificationEntity certification) async {
    final model = CertificationModel.fromEntity(certification);
    await _firestore.collection(_certificationsCollection).doc(certification.id).set(model.toJson());
  }

  @override
  Future<void> updateCertification(CertificationEntity certification) async {
    final model = CertificationModel.fromEntity(certification);
    await _firestore.collection(_certificationsCollection).doc(certification.id).update(model.toJson());
  }

  @override
  Future<void> deleteCertification(String id) async {
    await _firestore.collection(_certificationsCollection).doc(id).delete();
  }

  // Achievements
  @override
  Future<void> addAchievement(AchievementEntity achievement) async {
    final model = AchievementModel.fromEntity(achievement);
    await _firestore.collection(_achievementsCollection).doc(achievement.id).set(model.toJson());
  }

  @override
  Future<void> updateAchievement(AchievementEntity achievement) async {
    final model = AchievementModel.fromEntity(achievement);
    await _firestore.collection(_achievementsCollection).doc(achievement.id).update(model.toJson());
  }

  @override
  Future<void> deleteAchievement(String id) async {
    await _firestore.collection(_achievementsCollection).doc(id).delete();
  }

  // Expertise
  @override
  Future<void> addExpertise(ExpertiseEntity expertise) async {
    final model = ExpertiseModel.fromEntity(expertise);
    await _firestore.collection(_expertiseCollection).doc(expertise.id).set(model.toJson());
  }

  @override
  Future<void> updateExpertise(ExpertiseEntity expertise) async {
    final model = ExpertiseModel.fromEntity(expertise);
    await _firestore.collection(_expertiseCollection).doc(expertise.id).update(model.toJson());
  }

  @override
  Future<void> deleteExpertise(String id) async {
    await _firestore.collection(_expertiseCollection).doc(id).delete();
  }

  // Contact Info
  @override
  Future<void> addContactInfo(ContactInfoEntity info) async {
    final model = ContactInfoModel.fromEntity(info);
    await _firestore.collection(_contactInfoCollection).doc(info.id).set(model.toJson());
  }

  @override
  Future<void> updateContactInfo(ContactInfoEntity info) async {
    final model = ContactInfoModel.fromEntity(info);
    await _firestore.collection(_contactInfoCollection).doc(info.id).update(model.toJson());
  }

  @override
  Future<void> deleteContactInfo(String id) async {
    await _firestore.collection(_contactInfoCollection).doc(id).delete();
  }

  // Project Details
  @override
  Future<void> addProjectDetail(ProjectDetailEntity project) async {
    final model = ProjectDetailModel.fromEntity(project);
    await _firestore.collection(_projectDetailsCollection).doc(project.id).set(model.toJson());
  }

  @override
  Future<void> updateProjectDetail(ProjectDetailEntity project) async {
    final model = ProjectDetailModel.fromEntity(project);
    await _firestore.collection(_projectDetailsCollection).doc(project.id).update(model.toJson());
  }

  @override
  Future<void> deleteProjectDetail(String id) async {
    await _firestore.collection(_projectDetailsCollection).doc(id).delete();
  }

  // Hero Section
  @override
  Future<void> updateHeroSection(HeroSectionEntity heroSection) async {
    final model = HeroSectionModel.fromEntity(heroSection);
    await _firestore.collection(_heroSectionCollection).doc('main').set(model.toJson());
  }

  // ============ SEED DATA METHOD ============
  @override
  Future<void> seedInitialData() async {
    // This method will be implemented to seed initial data from local source
    // Called from admin panel when needed
  }
}
