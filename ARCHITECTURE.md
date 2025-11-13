# 🏗️ Architecture Documentation

Complete architectural overview of the Flutter Portfolio application.

## 📐 Clean Architecture Pattern

This application follows **Clean Architecture (MVVM)** with clear separation of concerns.

### Architecture Layers

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI, Controllers, Bindings, Widgets)   │
├─────────────────────────────────────────┤
│           Domain Layer                  │
│     (Business Logic, Use Cases)         │
├─────────────────────────────────────────┤
│            Data Layer                   │
│   (Models, Repositories, Data Sources)  │
└─────────────────────────────────────────┘
```

---

## 📂 Directory Structure

### `/lib/app`
Application-level configuration and routing.

```dart
app/
└── routes/
    ├── app_routes.dart    // Route constants
    └── app_pages.dart     // GetX page configurations with bindings
```

**Purpose:** Centralized navigation management

---

### `/lib/core`
Shared resources used across the entire application.

```dart
core/
├── constants/
│   ├── app_colors.dart              // Color palette
│   ├── app_assets.dart              // Asset paths
│   ├── animation_constants.dart     // Animation timings
│   └── responsive_constants.dart    // Breakpoints
├── theme/
│   └── app_theme.dart               // Material theme config
└── utils/
    ├── responsive_utils.dart        // Responsive helpers
    └── scroll_animations.dart       // Scroll animations
```

**Purpose:** Reusable utilities and configurations

---

### `/lib/data`
Data layer with models and repositories.

```dart
data/
├── models/
│   ├── skill_model.dart             // Skill data structure
│   └── project_model.dart           // Project data structure
└── repositories/
    └── portfolio_repository.dart    // Data access layer (Singleton)
```

**Responsibilities:**
- Data models with JSON serialization
- Repository pattern for data access
- Business data management
- Singleton pattern for shared state

**Example Model:**
```dart
class SkillModel {
  final String name;
  final double level;
  final String icon;
  final String category;
  
  // JSON serialization
  factory SkillModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

---

### `/lib/presentation`
Presentation layer following MVVM pattern.

```dart
presentation/
├── [feature]/
│   ├── bindings/
│   │   └── [feature]_binding.dart   // Dependency injection
│   ├── controllers/
│   │   └── [feature]_controller.dart // Business logic & state
│   └── views/
│       └── [feature]_view.dart      // UI components
└── widgets/
    └── shared_widgets.dart          // Reusable widgets
```

**Each feature follows the same pattern:**
- **Binding**: Injects dependencies using GetX
- **Controller**: Manages state and business logic
- **View**: Pure UI components, no business logic

---

## 🎯 MVVM Pattern Implementation

### Model
```dart
// Data models represent business entities
class ProjectModel {
  final String id;
  final String title;
  // ... properties
  
  // Factory constructor for JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json);
}
```

### View
```dart
// Pure UI - no business logic
class ProjectsView extends GetView<ProjectsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
      ? LoadingWidget()
      : ProjectsList(projects: controller.filteredProjects)
    );
  }
}
```

### ViewModel (Controller)
```dart
// Business logic and state management
class ProjectsController extends GetxController {
  final PortfolioRepository _repository = Get.find();
  
  final projects = <ProjectModel>[].obs;
  final isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadProjects();
  }
  
  Future<void> _loadProjects() async {
    isLoading.value = true;
    projects.value = await _repository.getProjects();
    isLoading.value = false;
  }
}
```

---

## 🔗 Dependency Injection

### GetX Bindings

Each page has a binding that injects required dependencies:

```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Singleton repository
    Get.lazyPut<PortfolioRepository>(
      () => PortfolioRepository(),
      fenix: true
    );
    
    // Controller for this page
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
```

**Benefits:**
- Lazy loading - controllers created only when needed
- Automatic disposal - prevents memory leaks
- Testability - easy to mock dependencies
- Reusability - shared instances across routes

---

## 🗺️ Navigation Flow

### Route Configuration

```dart
// app_routes.dart
abstract class AppRoutes {
  static const HOME = '/home';
  static const ABOUT = '/about';
  // ...
}

// app_pages.dart
static final routes = [
  GetPage(
    name: AppRoutes.HOME,
    page: () => const HomeView(),
    binding: HomeBinding(),
    transition: Transition.fadeIn,
  ),
];
```

### Navigation Usage

```dart
// Navigate to route
Get.toNamed(AppRoutes.ABOUT);

// Navigate with arguments
Get.toNamed(AppRoutes.PROJECTS, arguments: {'category': 'Mobile'});

// Navigate and remove previous
Get.offNamed(AppRoutes.HOME);

// Go back
Get.back();
```

---

## 📱 State Management

### GetX Reactive State

**Observables (`.obs`):**
```dart
final counter = 0.obs;               // Observable variable
final user = User().obs;            // Observable object
final items = <Item>[].obs;         // Observable list
```

**Reactivity (Obx):**
```dart
Obx(() => Text('Count: ${controller.counter.value}'))
```

**Update State:**
```dart
// Simple update
counter.value++;

// Update and trigger rebuild
counter.value = newValue;
```

### Controller Lifecycle

```dart
class MyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Initialize resources
  }
  
  @override
  void onReady() {
    super.onReady();
    // Called after widget is rendered
  }
  
  @override
  void onClose() {
    // Dispose resources
    super.onClose();
  }
}
```

---

## 📐 Responsive Design System

### Screen Types

```dart
enum ScreenType {
  mobile,      // < 600px
  smallTablet, // 600-900px
  tablet,      // 900-1200px
  desktop,     // 1200-1920px
  ultraWide,   // > 1920px
}
```

### Responsive Utilities

**Get responsive values:**
```dart
final fontSize = ResponsiveUtils.responsive<double>(
  context: context,
  mobile: 16,
  tablet: 18,
  desktop: 20,
  ultraWide: 24,
);
```

**Conditional layouts:**
```dart
ResponsiveLayout(
  mobile: MobileWidget(),
  tablet: TabletWidget(),
  desktop: DesktopWidget(),
)
```

**Screen type checks:**
```dart
if (ResponsiveUtils.isDesktop(context)) {
  // Desktop-specific code
}
```

---

## 🎨 Theme System

### Centralized Theme

```dart
// app_theme.dart
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      // ... theme configuration
    );
  }
}
```

### Color Palette

```dart
// app_colors.dart
class AppColors {
  // Primary colors
  static const primary = Color(0xFF00D4FF);
  static const neonBlue = Color(0xFF00F0FF);
  
  // Semantic colors
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFB0B0B0);
  
  // Effects
  static const glowBlue = Color(0xFF00D4FF);
}
```

---

## 🧩 Reusable Widgets

### Widget Library

Located in `/lib/presentation/widgets/`:

1. **GlassmorphismContainer** - Frosted glass effect
2. **NeonButton** - Electric blue glowing button
3. **SectionHeader** - Gradient text headers
4. **LottieAnimationWidget** - Lottie animation wrapper
5. **AppNavbar** - Navigation bar with routing

### Usage Example

```dart
GlassmorphismContainer(
  blur: 10,
  opacity: 0.5,
  child: Column(
    children: [
      SectionHeader(
        title: 'My Projects',
        icon: Icons.work,
      ),
      ProjectsList(),
    ],
  ),
)
```

---

## ⚡ Performance Optimizations

### Animation Performance

**Optimized durations:**
```dart
// Fast interactions
static const buttonHover = Duration(milliseconds: 200);

// Medium transitions
static const pageTransition = Duration(milliseconds: 400);

// Background animations
static const floating = Duration(milliseconds: 3000);
```

**Efficient curves:**
```dart
// Cubic curves for smooth 60fps
static const emphasized = Curves.easeOutCubic;
```

### Memory Management

**Lazy loading:**
```dart
Get.lazyPut<Controller>(() => Controller());
```

**Proper disposal:**
```dart
@override
void onClose() {
  animationController.dispose();
  scrollController.dispose();
  super.onClose();
}
```

### Build Optimizations

**Const constructors:**
```dart
const MyWidget({super.key});
```

**Builder widgets:**
```dart
// Only rebuild what changes
Obx(() => Text(controller.value))
```

---

## 🧪 Testing Strategy

### Unit Tests
Test business logic in controllers:

```dart
test('should load projects', () async {
  final controller = ProjectsController();
  await controller.loadProjects();
  expect(controller.projects.length, greaterThan(0));
});
```

### Widget Tests
Test UI components:

```dart
testWidgets('should display project cards', (tester) async {
  await tester.pumpWidget(ProjectsView());
  expect(find.byType(ProjectCard), findsWidgets);
});
```

### Integration Tests
Test complete user flows with GetX.

---

## 🔒 Best Practices

### Code Organization

✅ **DO:**
- One feature per folder
- Controllers only handle business logic
- Views only handle UI
- Use const constructors
- Dispose resources in onClose()

❌ **DON'T:**
- Mix business logic in views
- Put UI code in controllers
- Create global state unnecessarily
- Forget to dispose controllers

### State Management

✅ **DO:**
- Use `.obs` for reactive values
- Use `Obx()` for reactive UI
- Keep state in controllers
- Use repositories for data

❌ **DON'T:**
- Use setState in GetX
- Create unnecessary observables
- Mutate state directly without `.value`

### Navigation

✅ **DO:**
- Use named routes
- Inject dependencies via bindings
- Use GetX navigation methods

❌ **DON'T:**
- Use Navigator.push directly
- Create controllers manually
- Pass data through constructors (use arguments)

---

## 📊 Data Flow

```
User Action (View)
       ↓
Controller Method
       ↓
Repository Call
       ↓
Data Model
       ↓
Update Observable (.obs)
       ↓
Obx() Rebuilds View
```

---

## 🚀 Scalability

### Adding New Features

1. Create feature folder in `/presentation`
2. Create binding, controller, and view
3. Add model to `/data/models` if needed
4. Update repository if data access required
5. Add route to `/app/routes`
6. Implement feature

### Code Reusability

- Extract common widgets to `/presentation/widgets`
- Create utility functions in `/core/utils`
- Use composition over inheritance
- Follow DRY principle

---

## 📚 Further Reading

- [GetX Documentation](https://pub.dev/packages/get)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)

---

This architecture ensures:
- ✅ Maintainability
- ✅ Scalability
- ✅ Testability
- ✅ Performance
- ✅ Clean Code
- ✅ Separation of Concerns

**Built with professional standards for production-ready applications.**
