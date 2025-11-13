import 'package:get/get.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../controllers/skills_controller.dart';

class SkillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfolioRepository>(() => PortfolioRepository(), fenix: true);
    Get.lazyPut<SkillsController>(() => SkillsController());
  }
}
