import 'package:get/get.dart';

import '../../domain/usecases/stream/stream_usecases.dart';
import '../controllers/contact/contact_controller.dart';

/// Binding for Contact page dependencies with Firebase streams.
class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(
      () => ContactController(
        watchContactInfoUseCase: Get.find<WatchContactInfoUseCase>(),
        watchSocialLinksUseCase: Get.find<WatchSocialLinksUseCase>(),
      ),
    );
  }
}
