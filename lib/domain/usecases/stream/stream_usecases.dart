import '../../entities/entities.dart';
import '../../repositories/portfolio_repository_stream.dart';

/// Use case for watching services in real-time.
class WatchServicesUseCase {
  final PortfolioRepositoryStream _repository;
  WatchServicesUseCase(this._repository);
  Stream<List<ServiceEntity>> call() => _repository.watchServices();
}

/// Use case for watching portfolio items in real-time.
class WatchPortfolioItemsUseCase {
  final PortfolioRepositoryStream _repository;
  WatchPortfolioItemsUseCase(this._repository);
  Stream<List<PortfolioEntity>> call() => _repository.watchPortfolioItems();
}

/// Use case for watching social links in real-time.
class WatchSocialLinksUseCase {
  final PortfolioRepositoryStream _repository;
  WatchSocialLinksUseCase(this._repository);
  Stream<List<SocialLinkEntity>> call() => _repository.watchSocialLinks();
}

/// Use case for watching stats in real-time.
class WatchStatsUseCase {
  final PortfolioRepositoryStream _repository;
  WatchStatsUseCase(this._repository);
  Stream<List<StatEntity>> call() => _repository.watchStats();
}

/// Use case for watching nav items in real-time.
class WatchNavItemsUseCase {
  final PortfolioRepositoryStream _repository;
  WatchNavItemsUseCase(this._repository);
  Stream<List<NavItemEntity>> call() => _repository.watchNavItems();
}

/// Use case for watching profile in real-time.
class WatchProfileUseCase {
  final PortfolioRepositoryStream _repository;
  WatchProfileUseCase(this._repository);
  Stream<ProfileEntity> call() => _repository.watchProfile();
}

/// Use case for watching experiences in real-time.
class WatchExperiencesUseCase {
  final PortfolioRepositoryStream _repository;
  WatchExperiencesUseCase(this._repository);
  Stream<List<ExperienceEntity>> call() => _repository.watchExperiences();
}

/// Use case for watching education in real-time.
class WatchEducationUseCase {
  final PortfolioRepositoryStream _repository;
  WatchEducationUseCase(this._repository);
  Stream<List<EducationEntity>> call() => _repository.watchEducation();
}

/// Use case for watching certifications in real-time.
class WatchCertificationsUseCase {
  final PortfolioRepositoryStream _repository;
  WatchCertificationsUseCase(this._repository);
  Stream<List<CertificationEntity>> call() => _repository.watchCertifications();
}

/// Use case for watching achievements in real-time.
class WatchAchievementsUseCase {
  final PortfolioRepositoryStream _repository;
  WatchAchievementsUseCase(this._repository);
  Stream<List<AchievementEntity>> call() => _repository.watchAchievements();
}

/// Use case for watching expertise in real-time.
class WatchExpertiseUseCase {
  final PortfolioRepositoryStream _repository;
  WatchExpertiseUseCase(this._repository);
  Stream<List<ExpertiseEntity>> call() => _repository.watchExpertise();
}

/// Use case for watching contact info in real-time.
class WatchContactInfoUseCase {
  final PortfolioRepositoryStream _repository;
  WatchContactInfoUseCase(this._repository);
  Stream<List<ContactInfoEntity>> call() => _repository.watchContactInfo();
}

/// Use case for watching project details in real-time.
class WatchProjectDetailsUseCase {
  final PortfolioRepositoryStream _repository;
  WatchProjectDetailsUseCase(this._repository);
  Stream<List<ProjectDetailEntity>> call() => _repository.watchProjectDetails();
}
