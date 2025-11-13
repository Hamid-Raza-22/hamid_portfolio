# Flutter Developer Portfolio

A professional, futuristic portfolio website built with Flutter featuring **Clean Architecture**, **GetX State Management**, **Lottie Animations**, and a stunning **AI-inspired electric blue design**.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-8B5CF6?style=for-the-badge&logo=flutter&logoColor=white)

## Features

### Clean Architecture (MVVM Pattern)
- **Separation of Concerns**: Data, Domain, and Presentation layers
- **SOLID Principles**: Maintainable and scalable codebase
- **Dependency Injection**: GetX bindings for each module
- **Repository Pattern**: Centralized data management

### Futuristic UI/UX
- **Electric Blue Theme**: Neon glows and gradients throughout
- **Glassmorphism Effects**: Frosted glass containers with backdrop blur
- **AI-Inspired Animations**: Neural networks, particles, flowing waves
- **Lottie Animations**: Smooth vector animations for enhanced UX
- **60fps Performance**: Optimized animations and rendering

### Fully Responsive Design
Supports **5 screen types** with intelligent layout adaptation:
- Mobile (< 600px)
- Small Tablet (600px - 900px)
- Tablet (900px - 1200px)
- Desktop (1200px - 1920px)
- Ultra-Wide (> 1920px)

### Multi-Page Navigation
- Home: Complete portfolio showcase
- About: Biography, education, experience
- Skills: Technical skills with animated progress
- Projects: Project showcase with filters
- Contact: Contact form with validation

### State Management
- **GetX**: Reactive state management
- **Observables**: Real-time UI updates
- **Controllers**: Business logic separation
- **Bindings**: Lazy loading and dependency injection

## Project Structure

```
lib/
├── app/
│   └── routes/
│       ├── app_routes.dart              # Route constants
│       └── app_pages.dart               # GetX page configurations
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart              # Color palette
│   │   ├── app_assets.dart              # Asset paths
│   │   └── responsive_constants.dart    # Responsive breakpoints
│   ├── theme/
│   │   └── app_theme.dart               # App-wide theme
│   └── utils/
│       └── responsive_utils.dart        # Enhanced responsive utilities
│
├── data/
│   ├── models/
│   │   ├── skill_model.dart             # Skill data model
│   │   └── project_model.dart           # Project data model
│   └── repositories/
│       └── portfolio_repository.dart    # Data repository (Singleton)
│
├── presentation/
│   ├── home/
│   │   ├── bindings/
│   │   │   └── home_binding.dart
│   │   ├── controllers/
│   │   │   └── home_controller.dart
│   │   └── views/
│   │       └── home_view.dart
│   ├── about/
│   │   ├── bindings/about_binding.dart
│   │   ├── controllers/about_controller.dart
│   │   └── views/about_view.dart
│   ├── skills/
│   │   ├── bindings/skills_binding.dart
│   │   ├── controllers/skills_controller.dart
│   │   └── views/skills_view.dart
│   ├── projects/
│   │   ├── bindings/projects_binding.dart
│   │   ├── controllers/projects_controller.dart
│   │   └── views/projects_view.dart
│   ├── contact/
│   │   ├── bindings/contact_binding.dart
│   │   ├── controllers/contact_controller.dart
│   │   └── views/contact_view.dart
│   └── widgets/
│       ├── app_navbar.dart              # Shared navigation
│       ├── glassmorphism_container.dart # Glassmorphism widgets
│       ├── animated_buttons.dart        # Reusable buttons
│       ├── section_header.dart          # Section headers
│       └── lottie_animation_widget.dart # Lottie wrapper
│
└── main.dart                            # App entry point
```

## Getting Started

### Prerequisites
- Flutter SDK: `>=3.8.1`
- Dart SDK: `>=3.0.0`

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/hamid_portfolio.git
cd hamid_portfolio
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# Web
flutter run -d chrome

# Mobile
flutter run

# Desktop
flutter run -d windows  # or macos/linux
```

## Dependencies

### Core Dependencies
```yaml
get: ^4.7.2                    # State management & routing
google_fonts: ^6.1.0           # Modern typography
animated_text_kit: ^4.2.2      # Text animations
lottie: ^3.3.2                 # Lottie animations
flutter_animate: ^4.5.2        # Advanced animations
shimmer: ^3.0.0                # Shimmer effects
url_launcher: ^6.3.2           # Launch URLs
intl: ^0.19.0                  # Internationalization
```

## Customization

### Update Personal Information

**Edit Repository Data** (`lib/data/repositories/portfolio_repository.dart`):
```dart
Future<List<SkillModel>> getSkills() async {
  return [
    SkillModel(
      name: 'Your Skill',
      level: 0.95,  // 0.0 to 1.0
      icon: 'icon_name',
      category: 'Category',
    ),
    // Add more skills...
  ];
}
```

### Change Color Scheme

**Edit Colors** (`lib/core/constants/app_colors.dart`):
```dart
static const primary = Color(0xFF00D4FF);      // Your primary color
static const neonBlue = Color(0xFF00F0FF);     // Your accent color
// Customize all colors...
```

### Add Lottie Animations

1. Download Lottie files from [LottieFiles](https://lottiefiles.com/)
2. Place in `assets/lottie/` directory
3. Use the `LottieAnimationWidget`:

```dart
import 'package:hamid_portfolio/presentation/widgets/lottie_animation_widget.dart';

LottieAnimationWidget(
  assetPath: 'assets/lottie/your_animation.json',
  width: 300,
  height: 300,
)
```

## Navigation Usage

### Navigate Between Pages
```dart
import 'package:get/get.dart';
import 'package:hamid_portfolio/app/routes/app_routes.dart';

// Navigate to a page
Get.toNamed(AppRoutes.ABOUT);
Get.toNamed(AppRoutes.SKILLS);
Get.toNamed(AppRoutes.PROJECTS);
Get.toNamed(AppRoutes.CONTACT);

// Go back
Get.back();
```

## Responsive Design Usage

### Using ResponsiveUtils
```dart
import 'package:hamid_portfolio/core/utils/responsive_utils.dart';

// Get responsive values
final fontSize = ResponsiveUtils.responsiveFontSize(
  context,
  mobile: 16,
  tablet: 18,
  desktop: 20,
  ultraWide: 24,
);

// Check screen type
if (ResponsiveUtils.isDesktop(context)) {
  // Desktop-specific code
}

// Get grid columns
final columns = ResponsiveUtils.getGridColumnCount(
  context,
  mobile: 1,
  tablet: 2,
  desktop: 3,
  ultraWide: 4,
);
```

### Using ResponsiveLayout Widget
```dart
ResponsiveLayout(
  mobile: MobileWidget(),
  tablet: TabletWidget(),
  desktop: DesktopWidget(),
  ultraWide: UltraWideWidget(),
)
```

## Key Widgets

### Glassmorphism Container
```dart
GlassmorphismContainer(
  blur: 10,
  opacity: 0.5,
  child: YourWidget(),
)
```

### Neon Button
```dart
NeonButton(
  text: 'Click Me',
  icon: Icons.send,
  onPressed: () {},
)
```

### Section Header
```dart
SectionHeader(
  title: 'My Section',
  subtitle: 'Optional subtitle',
  icon: Icons.code,
)
```

## Architecture Benefits

✅ **Scalability**: Easy to add new features and pages  
✅ **Maintainability**: Clean separation of concerns  
✅ **Testability**: Business logic isolated in controllers  
✅ **Reusability**: Shared widgets and utilities  
✅ **Performance**: Optimized for 60fps  
✅ **Type Safety**: Strong typing with data models  
✅ **Clean Code**: Following SOLID principles  

## Screenshots

*(Add your portfolio screenshots here)*

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Author

**Hamid Raza**
- Portfolio: [Your Website]
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)

## Acknowledgments

- Flutter team for the amazing framework
- GetX for state management
- LottieFiles for animations
- Community for inspiration

---

Built with ❤️ using Flutter & GetX