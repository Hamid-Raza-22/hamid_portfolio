import 'package:get/get.dart';

import '../../domain/usecases/stream/stream_usecases.dart';
import '../controllers/home/home_controller.dart';

/// Binding class for Home feature.
/// Manages dependency injection for the Home page with Firebase streams.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        watchServicesUseCase: Get.find<WatchServicesUseCase>(),
        watchPortfolioItemsUseCase: Get.find<WatchPortfolioItemsUseCase>(),
        watchSocialLinksUseCase: Get.find<WatchSocialLinksUseCase>(),
        watchStatsUseCase: Get.find<WatchStatsUseCase>(),
        watchNavItemsUseCase: Get.find<WatchNavItemsUseCase>(),
        watchHeroSectionUseCase: Get.find<WatchHeroSectionUseCase>(),
      ),
    );
  }
}
