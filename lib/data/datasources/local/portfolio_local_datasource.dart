import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/portfolio_entity.dart';
import '../../../domain/entities/service_entity.dart';
import '../../../domain/entities/social_link_entity.dart';
import '../../../domain/entities/stat_entity.dart';
import '../../../domain/entities/nav_item_entity.dart';

/// Local data source providing static portfolio data.
/// In a real app, this could fetch from local storage, SharedPreferences, etc.
abstract class PortfolioLocalDataSource {
  List<ServiceEntity> getServices();
  List<PortfolioEntity> getPortfolioItems();
  List<SocialLinkEntity> getSocialLinks();
  List<StatEntity> getStats();
  List<NavItemEntity> getNavItems();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  List<ServiceEntity> getServices() {
    return const [
      ServiceEntity(
        id: 'service_1',
        icon: Icons.phone_android_rounded,
        title: 'Mobile Development',
        description: 'Building beautiful, high-performance Flutter apps for iOS & Android.',
        color: AppColors.servicePurple,
      ),
      ServiceEntity(
        id: 'service_2',
        icon: Icons.web_rounded,
        title: 'Web Development',
        description: 'Creating responsive, modern web applications with cutting-edge technologies.',
        color: AppColors.serviceBlue,
      ),
      ServiceEntity(
        id: 'service_3',
        icon: Icons.palette_rounded,
        title: 'UI/UX Design',
        description: 'Designing intuitive interfaces that delight users and drive engagement.',
        color: AppColors.servicePink,
      ),
      ServiceEntity(
        id: 'service_4',
        icon: Icons.api_rounded,
        title: 'API Integration',
        description: 'Seamlessly connecting your apps with powerful backend services.',
        color: AppColors.serviceGreen,
      ),
      ServiceEntity(
        id: 'service_5',
        icon: Icons.cloud_rounded,
        title: 'Cloud Solutions',
        description: 'Deploying scalable cloud infrastructure for your applications.',
        color: AppColors.serviceCyan,
      ),
      ServiceEntity(
        id: 'service_6',
        icon: Icons.support_agent_rounded,
        title: 'Consultation',
        description: 'Expert guidance on tech stack, architecture, and best practices.',
        color: AppColors.serviceOrange,
      ),
      ServiceEntity(
        id: 'service_7',
        icon: Icons.speed_rounded,
        title: 'Performance Optimization',
        description: 'Enhancing app speed and efficiency for the best user experience.',
        color: AppColors.serviceRed,
      ),
      ServiceEntity(
        id: 'service_8',
        icon: Icons.security_rounded,
        title: 'App Maintenance',
        description: 'Ongoing support, updates, and security patches for your apps.',
        color: AppColors.serviceYellow,
      ),
    ];
  }

  @override
  List<PortfolioEntity> getPortfolioItems() {
    return const [
      PortfolioEntity(
        id: 'portfolio_1',
        title: 'E-Commerce App',
        category: 'Mobile App',
        description: 'Full-featured shopping experience with Flutter',
        icon: Icons.shopping_bag_rounded,
        color: AppColors.servicePurple,
        tags: ['Flutter', 'Firebase', 'Stripe'],
      ),
      PortfolioEntity(
        id: 'portfolio_2',
        title: 'Healthcare Dashboard',
        category: 'Web App',
        description: 'Patient management system with analytics',
        icon: Icons.health_and_safety_rounded,
        color: AppColors.serviceGreen,
        tags: ['Flutter Web', 'REST API', 'Charts'],
      ),
      PortfolioEntity(
        id: 'portfolio_3',
        title: 'Social Media App',
        category: 'Mobile App',
        description: 'Real-time messaging and content sharing',
        icon: Icons.people_rounded,
        color: AppColors.serviceBlue,
        tags: ['Flutter', 'Socket.io', 'MongoDB'],
      ),
    ];
  }

  @override
  List<SocialLinkEntity> getSocialLinks() {
    return const [
      SocialLinkEntity(
        id: 'social_github',
        name: 'GitHub',
        icon: Icons.code_rounded,
        url: 'https://github.com/hamid-raza-22',
      ),
      SocialLinkEntity(
        id: 'social_linkedin',
        name: 'LinkedIn',
        icon: Icons.work_rounded,
        url: 'https://linkedin.com/in/hamid-raza',
      ),
      SocialLinkEntity(
        id: 'social_twitter',
        name: 'Twitter',
        icon: Icons.chat_bubble_rounded,
        url: 'https://twitter.com/hamid_raza',
      ),
      SocialLinkEntity(
        id: 'social_email',
        name: 'Email',
        icon: Icons.mail_rounded,
        url: 'mailto:hamid@example.com',
      ),
    ];
  }

  @override
  List<StatEntity> getStats() {
    return const [
      StatEntity(
        id: 'stat_projects',
        value: '50+',
        label: 'Projects\nCompleted',
      ),
      StatEntity(
        id: 'stat_clients',
        value: '30+',
        label: 'Happy\nClients',
      ),
      StatEntity(
        id: 'stat_experience',
        value: '3+',
        label: 'Years\nExperience',
      ),
    ];
  }

  @override
  List<NavItemEntity> getNavItems() {
    return const [
      NavItemEntity(id: 'nav_home', title: 'Home', sectionKey: 'home'),
      NavItemEntity(id: 'nav_services', title: 'Services', sectionKey: 'services'),
      NavItemEntity(id: 'nav_projects', title: 'Projects', sectionKey: 'portfolio'),
      NavItemEntity(id: 'nav_about', title: 'About', sectionKey: 'about'),
    ];
  }
}
