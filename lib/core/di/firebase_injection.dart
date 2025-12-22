import 'package:get/get.dart';

import '../../data/datasources/local/portfolio_local_datasource.dart';
import '../../data/datasources/local/portfolio_local_datasource_interface.dart';
import '../../data/datasources/remote/auth_datasource.dart';
import '../../data/datasources/remote/firebase_datasource.dart';
import '../../data/datasources/remote/storage_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/portfolio_repository_stream_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/portfolio_repository_stream.dart';
import '../../domain/usecases/admin/admin_usecases.dart';
import '../../domain/usecases/auth/auth_usecases.dart';
import '../../domain/usecases/stream/stream_usecases.dart';

/// Firebase Dependency Injection setup.
/// Registers all Firebase-related dependencies in GetX DI container.
class FirebaseInjection {
  FirebaseInjection._();

  static void init() {
    _registerDataSources();
    _registerRepositories();
    _registerStreamUseCases();
    _registerAdminUseCases();
    _registerAuthUseCases();
  }

  static void _registerDataSources() {
    // Local data source (fallback)
    Get.lazyPut<PortfolioLocalDataSource>(
      () => PortfolioLocalDataSourceImpl(),
      fenix: true,
    );

    // Firebase data source
    Get.lazyPut<FirebaseDataSource>(
      () => FirebaseDataSourceImpl(),
      fenix: true,
    );

    // Auth data source
    Get.lazyPut<AuthDataSource>(
      () => AuthDataSourceImpl(),
      fenix: true,
    );

    // Storage data source for image uploads
    Get.lazyPut<StorageDataSource>(
      () => StorageDataSourceImpl(),
      fenix: true,
    );
  }

  static void _registerRepositories() {
    // Stream repository for real-time updates
    Get.lazyPut<PortfolioRepositoryStream>(
      () => PortfolioRepositoryStreamImpl(
        firebaseDataSource: Get.find<FirebaseDataSource>(),
        localDataSource: Get.find<PortfolioLocalDataSource>(),
      ),
      fenix: true,
    );

    // Auth repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        authDataSource: Get.find<AuthDataSource>(),
      ),
      fenix: true,
    );
  }

  static void _registerStreamUseCases() {
    final repository = Get.find<PortfolioRepositoryStream>();

    Get.lazyPut(() => WatchServicesUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchPortfolioItemsUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchSocialLinksUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchStatsUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchNavItemsUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchProfileUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchExperiencesUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchEducationUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchCertificationsUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchAchievementsUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchExpertiseUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchContactInfoUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchProjectDetailsUseCase(repository), fenix: true);
  }

  static void _registerAdminUseCases() {
    final repository = Get.find<PortfolioRepositoryStream>();

    // Service CRUD
    Get.lazyPut(() => AddServiceUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateServiceUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteServiceUseCase(repository), fenix: true);

    // Portfolio CRUD
    Get.lazyPut(() => AddPortfolioItemUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdatePortfolioItemUseCase(repository), fenix: true);
    Get.lazyPut(() => DeletePortfolioItemUseCase(repository), fenix: true);

    // Experience CRUD
    Get.lazyPut(() => AddExperienceUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateExperienceUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteExperienceUseCase(repository), fenix: true);

    // Profile
    Get.lazyPut(() => UpdateProfileUseCase(repository), fenix: true);

    // Social Link CRUD
    Get.lazyPut(() => AddSocialLinkUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateSocialLinkUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteSocialLinkUseCase(repository), fenix: true);

    // Stat CRUD
    Get.lazyPut(() => AddStatUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateStatUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteStatUseCase(repository), fenix: true);

    // Nav Item CRUD
    Get.lazyPut(() => AddNavItemUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateNavItemUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteNavItemUseCase(repository), fenix: true);

    // Education CRUD
    Get.lazyPut(() => AddEducationUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateEducationUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteEducationUseCase(repository), fenix: true);

    // Certification CRUD
    Get.lazyPut(() => AddCertificationUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateCertificationUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteCertificationUseCase(repository), fenix: true);

    // Achievement CRUD
    Get.lazyPut(() => AddAchievementUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateAchievementUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteAchievementUseCase(repository), fenix: true);

    // Expertise CRUD
    Get.lazyPut(() => AddExpertiseUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateExpertiseUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteExpertiseUseCase(repository), fenix: true);

    // Contact Info CRUD
    Get.lazyPut(() => AddContactInfoUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateContactInfoUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteContactInfoUseCase(repository), fenix: true);

    // Project Detail CRUD
    Get.lazyPut(() => AddProjectDetailUseCase(repository), fenix: true);
    Get.lazyPut(() => UpdateProjectDetailUseCase(repository), fenix: true);
    Get.lazyPut(() => DeleteProjectDetailUseCase(repository), fenix: true);

    // Hero Section
    Get.lazyPut(() => UpdateHeroSectionUseCase(repository), fenix: true);

    // Seed data
    Get.lazyPut(() => SeedInitialDataUseCase(repository), fenix: true);
  }

  static void _registerAuthUseCases() {
    final repository = Get.find<AuthRepository>();

    Get.lazyPut(() => SignInUseCase(repository), fenix: true);
    Get.lazyPut(() => SignUpUseCase(repository), fenix: true);
    Get.lazyPut(() => SignOutUseCase(repository), fenix: true);
    Get.lazyPut(() => ResetPasswordUseCase(repository), fenix: true);
    Get.lazyPut(() => GetCurrentUserUseCase(repository), fenix: true);
    Get.lazyPut(() => WatchAuthStateUseCase(repository), fenix: true);
    Get.lazyPut(() => IsAuthenticatedUseCase(repository), fenix: true);
  }
}
