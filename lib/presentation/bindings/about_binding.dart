import 'package:get/get.dart';

import '../../domain/usecases/stream/stream_usecases.dart';
import '../controllers/about/about_controller.dart';

/// Binding for About page dependencies with Firebase streams.
class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(
      () => AboutController(
        watchProfileUseCase: Get.find<WatchProfileUseCase>(),
        watchExperiencesUseCase: Get.find<WatchExperiencesUseCase>(),
        watchEducationUseCase: Get.find<WatchEducationUseCase>(),
        watchCertificationsUseCase: Get.find<WatchCertificationsUseCase>(),
        watchAchievementsUseCase: Get.find<WatchAchievementsUseCase>(),
        watchExpertiseUseCase: Get.find<WatchExpertiseUseCase>(),
      ),
    );
  }
}
