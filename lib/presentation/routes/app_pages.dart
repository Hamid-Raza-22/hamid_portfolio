import 'package:get/get.dart';

import '../bindings/about_binding.dart';
import '../bindings/contact_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/projects_binding.dart';
import '../pages/about/about_page.dart';
import '../pages/contact/contact_page.dart';
import '../pages/home/home_page.dart';
import '../pages/projects/projects_page.dart';
import 'app_routes.dart';

/// Application page configuration for GetX routing.
/// Defines all routes with their bindings and transitions.
abstract class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutPage(),
      binding: AboutBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.projects,
      page: () => const ProjectsPage(),
      binding: ProjectsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
