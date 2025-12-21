import 'package:get/get.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/di/firebase_injection.dart';
import 'home_binding.dart';

/// Global application bindings.
/// Initializes core dependencies and feature-specific bindings.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize core dependencies (data sources, repositories, use cases)
    DependencyInjection.init();
    
    // Initialize Firebase dependencies (data sources, repositories, use cases)
    FirebaseInjection.init();

    // Initialize feature bindings
    HomeBinding().dependencies();
  }
}
