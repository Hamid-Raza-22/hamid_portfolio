import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/entities.dart';
import 'portfolio_local_datasource_interface.dart';

/// Implementation of PortfolioLocalDataSource.
/// Provides static portfolio data for the application.
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
        title: 'Asaan Rishta',
        category: 'Matrimonial App',
        description: 'Full-featured matrimonial platform with advanced matching algorithms, secure document-based profile verification, and end-to-end encrypted real-time chat. Multi-language support (Urdu/English). 4.8★ rating, 1100+ downloads on Play Store.',
        icon: Icons.favorite_rounded,
        color: AppColors.servicePink,
        tags: ['Flutter', 'Firebase', 'E2E Encryption', 'Multi-language'],
        projectUrl: 'https://play.google.com/store',
      ),
      PortfolioEntity(
        id: 'portfolio_2',
        title: 'BookIT App',
        category: 'Enterprise Mobility',
        description: 'Hybrid online/offline mobility solution handling 15,000+ daily transactions with 98% GPS accuracy. Bi-directional sync engine with 2.5MB+ daily data throughput, reducing data loss by 85%.',
        icon: Icons.book_rounded,
        color: AppColors.serviceBlue,
        tags: ['Flutter', 'HiveDB', 'WorkManager', 'GPX'],
      ),
      PortfolioEntity(
        id: 'portfolio_3',
        title: 'Crypto Coin Wallet',
        category: 'Cryptocurrency Platform',
        description: 'TRC-20/TRC-10 compliant wallet with cold storage integration, TRON transaction optimizations (45% cheaper), Ledger & Trezor hardware wallet support. 99.99% security compliance via smart contract audits.',
        icon: Icons.currency_bitcoin_rounded,
        color: AppColors.serviceOrange,
        tags: ['Flutter', 'Blockchain', 'Binance WebSocket', 'Biometric'],
      ),
      PortfolioEntity(
        id: 'portfolio_4',
        title: 'IR Remote Control',
        category: 'Utility App',
        description: 'Universal IR remote application with support for multiple devices. Clean MVVM architecture using GetX with device-specific drivers, custom remote configuration, and learning mode.',
        icon: Icons.settings_remote_rounded,
        color: AppColors.serviceGreen,
        tags: ['Flutter', 'GetX', 'MVVM', 'IR Blaster'],
      ),
      PortfolioEntity(
        id: 'portfolio_5',
        title: 'Screen Mirroring',
        category: 'Wireless Casting',
        description: 'Screen mirroring app supporting casting from Android to Smart TVs and desktops over WiFi. Low-latency streaming with adaptive bitrate for smooth video and audio playback.',
        icon: Icons.cast_rounded,
        color: AppColors.serviceCyan,
        tags: ['Flutter', 'WiFi Direct', 'Streaming', 'Adaptive Bitrate'],
      ),
      PortfolioEntity(
        id: 'portfolio_6',
        title: 'Al Noor Town App',
        category: 'Project Management',
        description: 'Real-time labor and construction tracking system covering 50+ blocks. Offline-first reliability with GPS verification. Reduced project reporting time by 70%. 4.7★ on Play Store.',
        icon: Icons.construction_rounded,
        color: AppColors.serviceYellow,
        tags: ['Flutter', 'GPS', 'Offline-First', 'Analytics'],
        projectUrl: 'https://play.google.com/store',
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
        url: 'https://github.com/Hamid-Raza-22',
      ),
      SocialLinkEntity(
        id: 'social_linkedin',
        name: 'LinkedIn',
        icon: Icons.work_rounded,
        url: 'https://linkedin.com/in/hamid-raza-22',
      ),
      SocialLinkEntity(
        id: 'social_email',
        name: 'Email',
        icon: Icons.mail_rounded,
        url: 'mailto:hamidraza.engr@gmail.com',
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

  @override
  ProfileEntity getProfile() {
    return const ProfileEntity(
      name: 'HAMID RAZA',
      title: 'Software Engineer | Flutter Developer | Mobile Architect | Technical Lead',
      experience: '3+ Years Experience',
      summary: 'Senior Flutter Developer with 3+ years of experience architecting cross-platform solutions. Specialized in performance optimization, CI/CD automation (60% faster deployments), and OWASP-compliant security. Led teams delivering enterprise applications serving 1500+ users.',
      workPreferences: 'Open to remote, hybrid, or on-site opportunities. Willing to relocate as needed for the right position.',
      location: 'Johar Town, Lahore, Pakistan',
      languages: 'Urdu (Native), English (Professional)',
    );
  }

  @override
  List<ExperienceEntity> getExperiences() {
    return const [
      ExperienceEntity(
        id: 'exp_1',
        title: 'Lead Flutter Department',
        company: 'Octa Logicx Pvt. Ltd.',
        location: 'Lahore, PK',
        duration: 'Jul 2025 – Present',
        highlights: [
          'Spearheaded the development of enterprise-scale Flutter applications serving 1100+ active users, achieving consistent 60 FPS performance.',
          'Established a Clean Architecture framework, reducing code complexity by 40% and improving scalability.',
          'Implemented CI/CD pipelines with GitHub Actions, reducing deployment cycles by 60%.',
          'Mentored and guided a team of 3 junior developers through structured code reviews.',
        ],
      ),
      ExperienceEntity(
        id: 'exp_2',
        title: 'Senior Flutter Developer',
        company: 'MetaXperts Pvt. Ltd.',
        location: 'Sialkot, PK',
        duration: 'Aug 2023 – Jul 2025',
        highlights: [
          'Led the design and delivery of cross-platform applications for enterprise clients.',
          'Optimized Firebase integrations that reduced backend costs by 30%.',
          'Enhanced application performance by implementing advanced caching and memory management.',
          'Mentored junior developers and introduced modern state management practices.',
        ],
      ),
      ExperienceEntity(
        id: 'exp_3',
        title: 'Junior Flutter Developer',
        company: 'Leopard Express',
        location: 'Sialkot, PK',
        duration: 'Jul 2022 – May 2023',
        highlights: [
          'Developed internal business tools in Flutter that automated workflows, saving 20+ hours weekly.',
          'Maintained SQL databases with 99.9% uptime for logistics processes.',
          'Collaborated with Agile cross-functional teams to deliver software solutions.',
        ],
      ),
    ];
  }

  @override
  List<EducationEntity> getEducation() {
    return const [
      EducationEntity(
        id: 'edu_1',
        degree: 'BS in Software Engineering',
        institution: 'University of Sialkot',
        duration: '2019 – 2023',
        cgpa: '3.2/4.0',
        specialization: 'Mobile Development',
        project: '"Polio Vaccination Management Systems"',
      ),
    ];
  }

  @override
  List<CertificationEntity> getCertifications() {
    return const [
      CertificationEntity(
        id: 'cert_1',
        title: 'Foundation of Project Management',
        issuer: 'Google',
        year: '2023',
      ),
      CertificationEntity(
        id: 'cert_2',
        title: 'SQL for Data Science',
        issuer: 'UC Davis',
        year: '2023',
      ),
      CertificationEntity(
        id: 'cert_3',
        title: 'Flutter Dart Programming',
        issuer: 'MetaXperts',
        year: '2024',
      ),
    ];
  }

  @override
  List<AchievementEntity> getAchievements() {
    return const [
      AchievementEntity(
        id: 'ach_1',
        icon: Icons.compress_rounded,
        text: 'Reduced app size by 40% through asset optimization',
      ),
      AchievementEntity(
        id: 'ach_2',
        icon: Icons.speed_rounded,
        text: 'Cut deployment time from 4hr to 30min via CI/CD',
      ),
      AchievementEntity(
        id: 'ach_3',
        icon: Icons.star_rounded,
        text: 'Recognized as Technical Lead within 1 year',
      ),
      AchievementEntity(
        id: 'ach_4',
        icon: Icons.code_rounded,
        text: 'Contributed to Flutter community packages',
      ),
    ];
  }

  @override
  List<ExpertiseEntity> getExpertise() {
    return const [
      ExpertiseEntity(
        id: 'exp_flutter',
        title: 'Flutter Ecosystem',
        icon: Icons.flutter_dash,
        color: AppColors.primary,
        skills: [
          'State Management: GetX, Bloc',
          'Navigation: GoRouter, AutoRoute',
          'Dependency Injection: GetIt',
          'Local Storage: Hive, SQFlite',
          'FCM, Push & Local Notifications',
          'Background Services: WorkManager',
          'Unit, Widget & Integration Testing',
          'Native Integration: FFI, Channels',
        ],
      ),
      ExpertiseEntity(
        id: 'exp_core',
        title: 'Core Competencies',
        icon: Icons.code_rounded,
        color: AppColors.accent,
        skills: [
          'Cross-Platform Development',
          'Clean Architecture (MVP, MVC, MVVM)',
          'Performance Optimization',
          'CI/CD Implementation',
          'Technical Leadership',
          'Security Protocols',
          'Internationalization (i18n)',
        ],
      ),
      ExpertiseEntity(
        id: 'exp_backend',
        title: 'Backend Integration',
        icon: Icons.cloud_rounded,
        color: AppColors.accentPurple,
        skills: [
          'RESTful APIs & GraphQL',
          'WebSockets, gRPC',
          'Firebase Suite',
          'Node.js: Express',
        ],
      ),
      ExpertiseEntity(
        id: 'exp_devops',
        title: 'DevOps Tools',
        icon: Icons.settings_rounded,
        color: AppColors.primaryLight,
        skills: [
          'CI/CD: GitHub Actions, Fastlane',
          'Docker, Kubernetes',
          'Charles Proxy',
          'SonarQube, Dart Linter',
        ],
      ),
      ExpertiseEntity(
        id: 'exp_uiux',
        title: 'UI/UX Implementation',
        icon: Icons.design_services_rounded,
        color: AppColors.accent,
        skills: [
          'Custom Widget Development',
          'Responsive Layouts',
          'Animation: Rive, Lottie',
          'Design System Implementation',
          'Figma-to-Code Conversion',
          'Accessibility (WCAG)',
        ],
      ),
      ExpertiseEntity(
        id: 'exp_security',
        title: 'Security',
        icon: Icons.security_rounded,
        color: AppColors.primary,
        skills: [
          'OWASP Mobile Top 10',
          'Data Encryption: AES-256, RSA',
          'Biometric Authentication',
          'ProGuard/R8 Obfuscation',
          'Secure Storage',
          'Certificate Pinning',
        ],
      ),
    ];
  }

  @override
  List<ContactInfoEntity> getContactInfo() {
    return const [
      ContactInfoEntity(
        id: 'contact_email',
        icon: Icons.email_rounded,
        title: 'Email',
        value: 'hamidraza.engr@gmail.com',
        color: AppColors.primary,
        actionType: 'email',
      ),
      ContactInfoEntity(
        id: 'contact_phone',
        icon: Icons.phone_rounded,
        title: 'Phone',
        value: '+92-313-1489445',
        color: AppColors.accent,
        actionType: 'phone',
      ),
      ContactInfoEntity(
        id: 'contact_whatsapp',
        icon: Icons.phone_android_rounded,
        title: 'WhatsApp',
        value: '+92-348-6255887',
        color: Color(0xFF25D366),
        actionType: 'whatsapp',
      ),
      ContactInfoEntity(
        id: 'contact_location',
        icon: Icons.location_on_rounded,
        title: 'Location',
        value: 'Johar Town, Lahore, Pakistan',
        color: AppColors.accentPurple,
        actionType: 'location',
      ),
    ];
  }

  @override
  List<ProjectDetailEntity> getProjectDetails() {
    return const [
      ProjectDetailEntity(
        id: 'proj_1',
        title: 'Asaan Rishta',
        category: 'Matrimonial Mobile Application',
        year: '2025',
        color: AppColors.servicePink,
        icon: Icons.favorite_rounded,
        description: 'Built a full-featured matrimonial platform with advanced matching algorithms, secure document-based profile verification, and end-to-end encrypted real-time chat.',
        highlights: [
          'Integrated advanced search filters (religion, caste, education, location)',
          'Custom privacy controls and in-app subscription model with payment gateway',
          'Complete multi-language support (Urdu/English) for broader adoption',
          'Released on Google Play Store with 4.8 rating and 1100+ downloads',
        ],
        tags: ['Flutter', 'Firebase', 'E2E Encryption', 'Multi-language', 'Payment Gateway'],
      ),
      ProjectDetailEntity(
        id: 'proj_2',
        title: 'IR Remote',
        category: 'Universal Remote Control App',
        year: '2025',
        color: AppColors.serviceGreen,
        icon: Icons.settings_remote_rounded,
        description: 'Developed a fully functional IR remote application replicating universal remotes with support for multiple devices.',
        highlights: [
          'Implemented clean MVVM architecture using GetX',
          'Device-specific drivers for seamless integration',
          'Custom remote configuration and learning mode',
          'User-friendly UI for quick setup',
        ],
        tags: ['Flutter', 'GetX', 'MVVM', 'IR Blaster'],
      ),
      ProjectDetailEntity(
        id: 'proj_3',
        title: 'Screen Mirroring',
        category: 'Wireless Casting Solution',
        year: '2025',
        color: AppColors.serviceCyan,
        icon: Icons.cast_rounded,
        description: 'Engineered a screen mirroring app supporting casting from Android to Smart TVs and desktops over WiFi.',
        highlights: [
          'Low-latency streaming with adaptive bitrate',
          'Smooth video and audio playback',
          'Real-time debugging overlay for monitoring bandwidth, FPS, and latency',
        ],
        tags: ['Flutter', 'WiFi Direct', 'Streaming', 'Adaptive Bitrate'],
      ),
      ProjectDetailEntity(
        id: 'proj_4',
        title: 'Personal Ledger System',
        category: 'Finance Management App',
        year: '2025',
        color: AppColors.serviceBlue,
        icon: Icons.account_balance_wallet_rounded,
        description: 'Built a personal finance tracker with expense categorization, income tracking, and daily summaries.',
        highlights: [
          'Secure local storage (HiveDB) with biometric authentication',
          'Automated monthly and yearly reports in PDF/Excel format',
          'Visual analytics for better financial insights',
        ],
        tags: ['Flutter', 'HiveDB', 'Biometric Auth', 'PDF/Excel Export'],
      ),
      ProjectDetailEntity(
        id: 'proj_5',
        title: 'BookIT App',
        category: 'Enterprise Mobility Solution',
        year: '2024-2025',
        color: AppColors.servicePurple,
        icon: Icons.book_rounded,
        description: 'Engineered a hybrid online/offline mobility solution using Flutter with HiveDB, handling 15,000+ daily transactions.',
        highlights: [
          '98% GPS accuracy through GPX file generation',
          'Bi-directional sync engine with WorkManager',
          '2.5MB+ daily data throughput, reducing data loss by 85%',
          'Automated operational dashboards and PDF reporting',
          'Cut documentation and reporting time by 65% per user',
        ],
        tags: ['Flutter', 'HiveDB', 'WorkManager', 'GPX', 'Offline-First'],
      ),
      ProjectDetailEntity(
        id: 'proj_6',
        title: 'Crypto Coin Wallet & Exchange',
        category: 'Cryptocurrency Platform',
        year: '2024',
        color: AppColors.serviceOrange,
        icon: Icons.currency_bitcoin_rounded,
        description: 'Developed a TRC-20/TRC-10 compliant wallet with cold storage integration and TRON transaction optimizations.',
        highlights: [
          '45% cheaper TRON transactions',
          'Support for Ledger & Trezor hardware wallets',
          'Real-time trading dashboards with Binance WebSocket integration',
          '99.99% security compliance via smart contract audits',
          'Biometric authentication (200ms signing speed)',
          'Multi-language support (EN/AR/UR) for global adoption',
        ],
        tags: ['Flutter', 'Blockchain', 'TRC-20', 'Binance WebSocket', 'Biometric'],
      ),
      ProjectDetailEntity(
        id: 'proj_7',
        title: 'Al Noor Town App',
        category: 'Project Management System',
        year: '2024',
        color: AppColors.serviceYellow,
        icon: Icons.construction_rounded,
        description: 'Built a real-time labor and construction tracking system covering 50+ blocks.',
        highlights: [
          'Daily progress insights with historical comparisons',
          'Offline-first reliability for remote areas',
          'GPS verification of worker locations',
          'Automated task completion updates',
          'Reduced project reporting time by 70%',
          'Published on Google Play Store with 4.7 rating',
        ],
        tags: ['Flutter', 'GPS', 'Offline-First', 'Analytics', 'Real-time'],
      ),
      ProjectDetailEntity(
        id: 'proj_8',
        title: 'E-Scooter Rental System',
        category: 'Full-stack Mobility Solution',
        year: '2024',
        color: AppColors.serviceGreen,
        icon: Icons.electric_scooter_rounded,
        description: 'Implemented GPS-based tracking and geofencing for secure scooter rentals.',
        highlights: [
          'Real-time ride monitoring',
          'Admin dashboard with usage analytics',
          'Fleet management capabilities',
          'Open-source project',
        ],
        tags: ['Flutter', 'GPS', 'Geofencing', 'Admin Dashboard'],
      ),
      ProjectDetailEntity(
        id: 'proj_9',
        title: 'Courage ERP System',
        category: 'Enterprise Resource Planning',
        year: '2023-2024',
        color: AppColors.serviceBlue,
        icon: Icons.business_rounded,
        description: 'Led development of a full ERP system with real-time cross-platform synchronization.',
        highlights: [
          'Automated PDF reporting features',
          'Optimized inventory management workflows',
          'Improved visibility and efficiency across departments',
          'Published on Google Play Store with 4.7 rating (200+ downloads)',
        ],
        tags: ['Flutter', 'ERP', 'Real-time Sync', 'PDF Reports'],
      ),
      ProjectDetailEntity(
        id: 'proj_10',
        title: 'Valor Trading Platform',
        category: 'B2B Solution',
        year: '2023',
        color: AppColors.serviceRed,
        icon: Icons.trending_up_rounded,
        description: 'Developed a secure trading platform with JWT authentication and integrated payment gateways.',
        highlights: [
          'Stripe/Razorpay payment integration',
          'Fraud detection mechanisms',
          'Real-time market dashboards',
          'Analytics and reporting tools for enterprise clients',
          'Released on Google Play Store with 4.0 rating and 50+ downloads',
        ],
        tags: ['Flutter', 'JWT', 'Stripe', 'Razorpay', 'Analytics'],
      ),
    ];
  }
}
