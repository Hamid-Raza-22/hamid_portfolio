import 'package:get/get.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register repository (singleton)
    Get.lazyPut<PortfolioRepository>(() => PortfolioRepository(), fenix: true);
    
    // Register home controller
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
