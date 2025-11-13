import '../models/skill_model.dart';
import '../models/project_model.dart';

class PortfolioRepository {
  // Singleton pattern for repository
  static final PortfolioRepository _instance = PortfolioRepository._internal();
  factory PortfolioRepository() => _instance;
  PortfolioRepository._internal();

  // Get all skills
  Future<List<SkillModel>> getSkills() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      // Mobile Development
      SkillModel(
        name: 'Flutter & Dart',
        level: 0.95,
        icon: 'flutter_dash',
        category: 'Mobile Development',
        description: '3+ years building cross-platform solutions with 60 FPS performance',
      ),
      SkillModel(
        name: 'Clean Architecture',
        level: 0.93,
        icon: 'architecture',
        category: 'Mobile Development',
        description: 'MVP, MVC, MVVM - Reduced code complexity by 40%',
      ),
      SkillModel(
        name: 'Performance Optimization',
        level: 0.90,
        icon: 'speed',
        category: 'Mobile Development',
        description: 'Advanced rendering optimizations, caching, memory management',
      ),
      
      // State Management & Navigation
      SkillModel(
        name: 'GetX',
        level: 0.95,
        icon: 'layers',
        category: 'State Management',
        description: 'Expert in state management, routing, and dependency injection',
      ),
      SkillModel(
        name: 'Bloc Pattern',
        level: 0.88,
        icon: 'pattern',
        category: 'State Management',
        description: 'Business logic separation with reactive programming',
      ),
      SkillModel(
        name: 'GoRouter & AutoRoute',
        level: 0.85,
        icon: 'navigation',
        category: 'State Management',
        description: 'Type-safe navigation with declarative routing',
      ),
      
      // Backend Integration
      SkillModel(
        name: 'RESTful APIs',
        level: 0.92,
        icon: 'api',
        category: 'Backend',
        description: 'Expert API integration and error handling',
      ),
      SkillModel(
        name: 'Firebase Suite',
        level: 0.90,
        icon: 'cloud',
        category: 'Backend',
        description: 'Firestore, Auth, Analytics - Reduced costs by 30%',
      ),
      SkillModel(
        name: 'GraphQL & WebSockets',
        level: 0.85,
        icon: 'sync',
        category: 'Backend',
        description: 'Real-time data synchronization and efficient queries',
      ),
      SkillModel(
        name: 'Node.js & Express',
        level: 0.80,
        icon: 'server',
        category: 'Backend',
        description: 'Backend API development and server-side logic',
      ),
      
      // Local Storage
      SkillModel(
        name: 'Hive & SQFLite',
        level: 0.92,
        icon: 'storage',
        category: 'Database',
        description: 'Offline-first apps with 99.9% uptime',
      ),
      
      // UI/UX Implementation
      SkillModel(
        name: 'Custom Widgets',
        level: 0.93,
        icon: 'widgets',
        category: 'UI/UX',
        description: 'Beautiful, reusable components with design systems',
      ),
      SkillModel(
        name: 'Responsive Design',
        level: 0.95,
        icon: 'devices',
        category: 'UI/UX',
        description: 'Adaptive layouts for mobile, tablet, and desktop',
      ),
      SkillModel(
        name: 'Rive & Lottie',
        level: 0.88,
        icon: 'animation',
        category: 'UI/UX',
        description: 'Advanced animations and micro-interactions',
      ),
      SkillModel(
        name: 'Figma to Code',
        level: 0.90,
        icon: 'design',
        category: 'UI/UX',
        description: 'Pixel-perfect implementation from designs',
      ),
      SkillModel(
        name: 'Accessibility (WCAG)',
        level: 0.85,
        icon: 'accessibility',
        category: 'UI/UX',
        description: 'Inclusive design for all users',
      ),
      
      // DevOps & CI/CD
      SkillModel(
        name: 'GitHub Actions',
        level: 0.90,
        icon: 'cicd',
        category: 'DevOps',
        description: 'Automated deployments - 60% faster releases',
      ),
      SkillModel(
        name: 'Docker & Kubernetes',
        level: 0.75,
        icon: 'container',
        category: 'DevOps',
        description: 'Containerization and orchestration',
      ),
      SkillModel(
        name: 'Shorebird & FVM',
        level: 0.85,
        icon: 'deploy',
        category: 'DevOps',
        description: 'Code push and Flutter version management',
      ),
      
      // Security
      SkillModel(
        name: 'OWASP Mobile Top 10',
        level: 0.88,
        icon: 'security',
        category: 'Security',
        description: 'Security-first development practices',
      ),
      SkillModel(
        name: 'Data Encryption',
        level: 0.87,
        icon: 'lock',
        category: 'Security',
        description: 'AES-256, RSA encryption for sensitive data',
      ),
      SkillModel(
        name: 'Biometric Auth',
        level: 0.90,
        icon: 'fingerprint',
        category: 'Security',
        description: 'Secure authentication with biometrics',
      ),
      
      // Testing
      SkillModel(
        name: 'Testing Suite',
        level: 0.85,
        icon: 'testing',
        category: 'Quality',
        description: 'Unit, Widget, Integration tests for quality assurance',
      ),
      
      // Leadership
      SkillModel(
        name: 'Technical Leadership',
        level: 0.88,
        icon: 'leadership',
        category: 'Soft Skills',
        description: 'Led teams of 3+ developers, mentoring and code reviews',
      ),
      SkillModel(
        name: 'Agile & Scrum',
        level: 0.85,
        icon: 'agile',
        category: 'Soft Skills',
        description: 'Collaborative development with cross-functional teams',
      ),
    ];
  }

  // Get skills by category
  Future<List<SkillModel>> getSkillsByCategory(String category) async {
    final allSkills = await getSkills();
    return allSkills.where((skill) => skill.category == category).toList();
  }

  // Get all projects
  Future<List<ProjectModel>> getProjects() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      ProjectModel(
        id: '1',
        title: 'Asaan Rishta',
        description: 'Matrimonial Mobile Application with 600+ downloads',
        longDescription: 'Built a full-featured matrimonial platform with advanced matching algorithms, secure document-based profile verification, and end-to-end encrypted real-time chat. Integrated advanced search filters (religion, caste, education, location), custom privacy controls, and an in-app subscription model with payment gateway support. Delivered complete multi-language support (Urdu/English) for broader adoption across diverse user segments.',
        imageUrl: 'assets/images/asaan_rishta.png',
        technologies: ['Flutter', 'Firebase', 'GetX', 'E2E Encryption', 'Payment Gateway'],
        liveUrl: 'https://play.google.com/store/apps/details?id=com.asaanrishta',
        category: 'Mobile',
        completedDate: DateTime(2025, 6, 1),
        isFeatured: true,
      ),
      ProjectModel(
        id: '2',
        title: 'BookIT App',
        description: 'Enterprise Mobility Solution - 15,000+ daily transactions',
        longDescription: 'Engineered a hybrid online/offline mobility solution using Flutter with HiveDB, handling 15,000+ daily transactions and delivering 98% GPS accuracy through GPX file generation. Designed a bi-directional sync engine with WorkManager, enabling 2.5MB+ daily data throughput and reducing data loss by 85% through optimized conflict resolution. Automated operational dashboards and PDF reporting, cutting documentation and reporting time by 65% per user.',
        imageUrl: 'assets/images/bookit.png',
        technologies: ['Flutter', 'HiveDB', 'WorkManager', 'GPS', 'PDF Generation', 'MVVM'],
        category: 'Mobile',
        completedDate: DateTime(2024, 12, 15),
        isFeatured: true,
      ),
      ProjectModel(
        id: '3',
        title: 'Crypto Coin Wallet & Exchange',
        description: 'TRC-20/TRC-10 Compliant Cryptocurrency Platform',
        longDescription: 'Developed a TRC-20/TRC-10 compliant wallet with cold storage integration, TRON transaction optimizations (45% cheaper), and support for Ledger & Trezor hardware wallets. Implemented real-time trading dashboards with Binance WebSocket integration and ensured 99.99% security compliance via smart contract audits. Added biometric authentication (200ms signing speed) and multi-language support (EN/AR/UR) for global user adoption.',
        imageUrl: 'assets/images/crypto_wallet.png',
        technologies: ['Flutter', 'TRON', 'WebSocket', 'Blockchain', 'Biometric Auth', 'GetX'],
        githubUrl: 'https://github.com/Hamid-Raza-22',
        category: 'Mobile',
        completedDate: DateTime(2024, 8, 20),
        isFeatured: true,
      ),
      ProjectModel(
        id: '4',
        title: 'Al Noor Town App',
        description: 'Project Management System - 4.7★ Rating',
        longDescription: 'Built a real-time labor and construction tracking system covering 50+ blocks, including daily progress insights with historical comparisons. Delivered offline-first reliability for remote areas with GPS verification of worker locations and automated task completion updates. Reduced project reporting time by 70% through automated reporting and streamlined owner oversight.',
        imageUrl: 'assets/images/al_noor_town.png',
        technologies: ['Flutter', 'GPS', 'Offline-First', 'Real-time Sync', 'PDF Reports'],
        liveUrl: 'https://play.google.com/store/apps/details?id=com.alnoortownapp',
        category: 'Mobile',
        completedDate: DateTime(2024, 6, 10),
        isFeatured: true,
      ),
      ProjectModel(
        id: '5',
        title: 'Courage ERP System',
        description: 'Enterprise Resource Planning - 4.7★ Rating, 200+ downloads',
        longDescription: 'Led development of a full ERP system with real-time cross-platform synchronization and automated PDF reporting features. Optimized inventory management workflows, improving visibility and efficiency across departments. Built with clean architecture for scalability and maintainability.',
        imageUrl: 'assets/images/courage_erp.png',
        technologies: ['Flutter', 'Firebase', 'PDF', 'Real-time Sync', 'Clean Architecture'],
        liveUrl: 'https://play.google.com/store/apps/details?id=com.courage.erp',
        category: 'Mobile',
        completedDate: DateTime(2024, 3, 15),
        isFeatured: true,
      ),
      ProjectModel(
        id: '6',
        title: 'IR Remote',
        description: 'Universal Remote Control App',
        longDescription: 'Developed a fully functional IR remote application replicating universal remotes with support for multiple devices. Implemented clean MVVM architecture using GetX with device-specific drivers for seamless integration. Added custom remote configuration, learning mode, and user-friendly UI for quick setup.',
        imageUrl: 'assets/images/ir_remote.png',
        technologies: ['Flutter', 'IR Blaster', 'GetX', 'MVVM', 'Native Integration'],
        category: 'Mobile',
        completedDate: DateTime(2025, 4, 1),
        isFeatured: false,
      ),
      ProjectModel(
        id: '7',
        title: 'Screen Mirroring',
        description: 'Wireless Casting Solution',
        longDescription: 'Engineered a screen mirroring app supporting casting from Android to Smart TVs and desktops over WiFi. Implemented low-latency streaming with adaptive bitrate for smooth video and audio playback. Added real-time debugging overlay for monitoring bandwidth, FPS, and latency metrics.',
        imageUrl: 'assets/images/screen_mirroring.png',
        technologies: ['Flutter', 'WebRTC', 'Streaming', 'Adaptive Bitrate', 'WiFi Direct'],
        category: 'Mobile',
        completedDate: DateTime(2025, 3, 15),
        isFeatured: false,
      ),
      ProjectModel(
        id: '8',
        title: 'Personal Ledger System',
        description: 'Finance Management App',
        longDescription: 'Built a personal finance tracker with expense categorization, income tracking, and daily summaries. Integrated secure local storage (HiveDB) with biometric authentication for data privacy. Automated monthly and yearly reports in PDF/Excel format with visual analytics.',
        imageUrl: 'assets/images/personal_ledger.png',
        technologies: ['Flutter', 'HiveDB', 'Biometric Auth', 'PDF/Excel Export', 'Charts'],
        category: 'Mobile',
        completedDate: DateTime(2025, 2, 1),
        isFeatured: false,
      ),
      ProjectModel(
        id: '9',
        title: 'E-Scooter Rental System',
        description: 'Full-stack Mobility Solution',
        longDescription: 'Implemented GPS-based tracking and geofencing for secure scooter rentals, along with real-time ride monitoring. Built an admin dashboard with usage analytics and fleet management capabilities for operational efficiency.',
        imageUrl: 'assets/images/escooter.png',
        technologies: ['Flutter', 'GPS', 'Geofencing', 'Admin Dashboard', 'Real-time'],
        githubUrl: 'https://github.com/Hamid-Raza-22',
        category: 'Mobile',
        completedDate: DateTime(2024, 5, 20),
        isFeatured: false,
      ),
      ProjectModel(
        id: '10',
        title: 'Valor Trading Platform',
        description: 'B2B Solution - 4.0★ Rating, 50+ downloads',
        longDescription: 'Developed a secure trading platform with JWT authentication and integrated Stripe/Razorpay payments, including fraud detection mechanisms. Implemented real-time market dashboards with analytics and reporting tools for enterprise clients.',
        imageUrl: 'assets/images/valor_trading.png',
        technologies: ['Flutter', 'JWT', 'Stripe', 'Razorpay', 'Real-time Analytics', 'Security'],
        liveUrl: 'https://play.google.com/store/apps/details?id=com.valor.trading',
        category: 'Mobile',
        completedDate: DateTime(2023, 12, 10),
        isFeatured: false,
      ),
    ];
  }

  // Get featured projects
  Future<List<ProjectModel>> getFeaturedProjects() async {
    final allProjects = await getProjects();
    return allProjects.where((project) => project.isFeatured).toList();
  }

  // Get projects by category
  Future<List<ProjectModel>> getProjectsByCategory(String category) async {
    final allProjects = await getProjects();
    return allProjects.where((project) => project.category == category).toList();
  }

  // Get project by ID
  Future<ProjectModel?> getProjectById(String id) async {
    final allProjects = await getProjects();
    try {
      return allProjects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }
}
