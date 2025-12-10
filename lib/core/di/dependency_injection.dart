import 'package:get/get.dart';

import '../../data/datasources/local/portfolio_local_datasource.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/usecases/usecases.dart';

/// Dependency Injection setup following Clean Architecture.
/// Registers all dependencies in GetX dependency injection container.
class DependencyInjection {
  static void init() {
    // Data Sources
    Get.lazyPut<PortfolioLocalDataSource>(
      () => PortfolioLocalDataSourceImpl(),
      fenix: true,
    );

    // Repositories
    Get.lazyPut<PortfolioRepository>(
      () => PortfolioRepositoryImpl(
        localDataSource: Get.find<PortfolioLocalDataSource>(),
      ),
      fenix: true,
    );

    // Use Cases
    Get.lazyPut<GetServicesUseCase>(
      () => GetServicesUseCase(Get.find<PortfolioRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetPortfolioItemsUseCase>(
      () => GetPortfolioItemsUseCase(Get.find<PortfolioRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetSocialLinksUseCase>(
      () => GetSocialLinksUseCase(Get.find<PortfolioRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetStatsUseCase>(
      () => GetStatsUseCase(Get.find<PortfolioRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetNavItemsUseCase>(
      () => GetNavItemsUseCase(Get.find<PortfolioRepository>()),
      fenix: true,
    );
  }
}
