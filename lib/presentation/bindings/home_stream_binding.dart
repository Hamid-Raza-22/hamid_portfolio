import 'package:get/get.dart';

import '../../domain/usecases/stream/stream_usecases.dart';
import '../controllers/home/home_stream_controller.dart';

/// Binding class for Home feature with real-time Firebase streams.
class HomeStreamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeStreamController>(
      () => HomeStreamController(
        watchServicesUseCase: Get.find<WatchServicesUseCase>(),
        watchPortfolioItemsUseCase: Get.find<WatchPortfolioItemsUseCase>(),
        watchSocialLinksUseCase: Get.find<WatchSocialLinksUseCase>(),
        watchStatsUseCase: Get.find<WatchStatsUseCase>(),
        watchNavItemsUseCase: Get.find<WatchNavItemsUseCase>(),
      ),
    );
  }
}
