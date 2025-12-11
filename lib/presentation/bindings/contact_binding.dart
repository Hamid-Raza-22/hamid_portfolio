import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../controllers/contact/contact_controller.dart';

/// Binding for Contact page dependencies.
class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(
      () => ContactController(
        getContactInfoUseCase: Get.find<GetContactInfoUseCase>(),
        getSocialLinksUseCase: Get.find<GetSocialLinksUseCase>(),
      ),
    );
  }
}
