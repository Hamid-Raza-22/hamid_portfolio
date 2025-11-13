import 'package:get/get.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../controllers/projects_controller.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfolioRepository>(() => PortfolioRepository(), fenix: true);
    Get.lazyPut<ProjectsController>(() => ProjectsController());
  }
}
