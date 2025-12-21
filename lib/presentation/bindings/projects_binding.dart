import 'package:get/get.dart';

import '../../domain/usecases/stream/stream_usecases.dart';
import '../controllers/projects/projects_controller.dart';

/// Binding for Projects page dependencies with Firebase streams.
class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(
      () => ProjectsController(
        watchProjectDetailsUseCase: Get.find<WatchProjectDetailsUseCase>(),
      ),
    );
  }
}
