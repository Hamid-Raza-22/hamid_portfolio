import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../controllers/projects/projects_controller.dart';

/// Binding for Projects page dependencies.
class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(
      () => ProjectsController(
        getProjectDetailsUseCase: Get.find<GetProjectDetailsUseCase>(),
      ),
    );
  }
}
