import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../controllers/about/about_controller.dart';

/// Binding for About page dependencies.
class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(
      () => AboutController(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        getExperiencesUseCase: Get.find<GetExperiencesUseCase>(),
        getEducationUseCase: Get.find<GetEducationUseCase>(),
        getCertificationsUseCase: Get.find<GetCertificationsUseCase>(),
        getAchievementsUseCase: Get.find<GetAchievementsUseCase>(),
        getExpertiseUseCase: Get.find<GetExpertiseUseCase>(),
      ),
    );
  }
}
