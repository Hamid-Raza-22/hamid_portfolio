import 'package:get/get.dart';

import '../../data/datasources/local/portfolio_local_datasource.dart';
import '../../data/datasources/local/portfolio_local_datasource_interface.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/usecases/usecases.dart';

/// Dependency Injection setup following Clean Architecture.
/// Registers all dependencies in GetX dependency injection container.
class DependencyInjection {
  DependencyInjection._();

  static void init() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
  }

  static void _registerDataSources() {
    Get.lazyPut<PortfolioLocalDataSource>(
      () => PortfolioLocalDataSourceImpl(),
      fenix: true,
    );
  }

  static void _registerRepositories() {
    Get.lazyPut<PortfolioRepository>(
      () => PortfolioRepositoryImpl(
        localDataSource: Get.find<PortfolioLocalDataSource>(),
      ),
      fenix: true,
    );
  }

  static void _registerUseCases() {
    final repository = Get.find<PortfolioRepository>();

    // Core use cases
    Get.lazyPut<GetServicesUseCase>(
      () => GetServicesUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetPortfolioItemsUseCase>(
      () => GetPortfolioItemsUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetSocialLinksUseCase>(
      () => GetSocialLinksUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetStatsUseCase>(
      () => GetStatsUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetNavItemsUseCase>(
      () => GetNavItemsUseCase(repository),
      fenix: true,
    );

    // About page use cases
    Get.lazyPut<GetProfileUseCase>(
      () => GetProfileUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetExperiencesUseCase>(
      () => GetExperiencesUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetEducationUseCase>(
      () => GetEducationUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetCertificationsUseCase>(
      () => GetCertificationsUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetAchievementsUseCase>(
      () => GetAchievementsUseCase(repository),
      fenix: true,
    );

    Get.lazyPut<GetExpertiseUseCase>(
      () => GetExpertiseUseCase(repository),
      fenix: true,
    );

    // Contact page use cases
    Get.lazyPut<GetContactInfoUseCase>(
      () => GetContactInfoUseCase(repository),
      fenix: true,
    );

    // Projects page use cases
    Get.lazyPut<GetProjectDetailsUseCase>(
      () => GetProjectDetailsUseCase(repository),
      fenix: true,
    );
  }
}
