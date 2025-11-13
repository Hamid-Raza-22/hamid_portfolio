import 'package:get/get.dart';
import '../../presentation/home/bindings/home_binding.dart';
import '../../presentation/home/views/home_view.dart';
import '../../presentation/about/bindings/about_binding.dart';
import '../../presentation/about/views/about_view.dart';
import '../../presentation/skills/bindings/skills_binding.dart';
import '../../presentation/skills/views/skills_view.dart';
import '../../presentation/projects/bindings/projects_binding.dart';
import '../../presentation/projects/views/projects_view.dart';
import '../../presentation/contact/bindings/contact_binding.dart';
import '../../presentation/contact/views/contact_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;

  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.SKILLS,
      page: () => const SkillsView(),
      binding: SkillsBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.PROJECTS,
      page: () => const ProjectsView(),
      binding: ProjectsBinding(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
