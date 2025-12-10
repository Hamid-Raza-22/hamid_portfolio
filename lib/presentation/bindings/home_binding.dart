import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../controllers/home/home_controller.dart';

/// Binding class for Home feature.
/// Manages dependency injection for the Home page.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        getServicesUseCase: Get.find<GetServicesUseCase>(),
        getPortfolioItemsUseCase: Get.find<GetPortfolioItemsUseCase>(),
        getSocialLinksUseCase: Get.find<GetSocialLinksUseCase>(),
        getStatsUseCase: Get.find<GetStatsUseCase>(),
        getNavItemsUseCase: Get.find<GetNavItemsUseCase>(),
      ),
    );
  }
}
