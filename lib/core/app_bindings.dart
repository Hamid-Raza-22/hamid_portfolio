import 'package:get/get.dart';
import '../models/home/home_binding.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    HomeBindings().dependencies();
  }
}