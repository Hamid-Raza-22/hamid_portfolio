import 'package:get/get.dart';

import '../../../domain/usecases/auth/auth_usecases.dart';
import '../../controllers/admin/auth_controller.dart';

/// Binding class for Auth feature.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        signInUseCase: Get.find<SignInUseCase>(),
        signUpUseCase: Get.find<SignUpUseCase>(),
        signOutUseCase: Get.find<SignOutUseCase>(),
        resetPasswordUseCase: Get.find<ResetPasswordUseCase>(),
        watchAuthStateUseCase: Get.find<WatchAuthStateUseCase>(),
        isAuthenticatedUseCase: Get.find<IsAuthenticatedUseCase>(),
      ),
    );
  }
}
