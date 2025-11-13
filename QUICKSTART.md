# 🚀 Quick Start Guide

Get your portfolio up and running in 5 minutes!

## ⚡ Quick Setup

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
# For Web (Recommended for testing)
flutter run -d chrome

# For Mobile
flutter run

# For Desktop
flutter run -d windows  # or macos/linux
```

That's it! Your portfolio is now running with the default template.

## 🎨 Customize Your Portfolio

### Step 1: Update Personal Info

**Edit `lib/data/repositories/portfolio_repository.dart`**

Replace the default data with your own:

```dart
// Update your skills
Future<List<SkillModel>> getSkills() async {
  return [
    SkillModel(
      name: 'Flutter & Dart',
      level: 0.95,  // Your skill level (0.0 to 1.0)
      icon: 'flutter_dash',
      category: 'Mobile Development',
      description: 'Your expertise description',
    ),
    // Add more skills...
  ];
}

// Update your projects
Future<List<ProjectModel>> getProjects() async {
  return [
    ProjectModel(
      id: '1',
      title: 'Your Project Name',
      description: 'Brief description',
      longDescription: 'Detailed description',
      imageUrl: 'assets/images/project1.png',
      technologies: ['Flutter', 'Firebase', 'GetX'],
      githubUrl: 'https://github.com/yourusername/project',
      liveUrl: 'https://your-project-url.com',
      category: 'Mobile',  // or 'Web', 'Desktop'
      isFeatured: true,
    ),
    // Add more projects...
  ];
}
```

### Step 2: Update About Page

**Edit `lib/presentation/about/views/about_view.dart`**

Find and replace the story/education/experience text:

```dart
Widget _buildStory(BuildContext context) {
  return Container(
    // ... existing code
    child: Text(
      'Your personal story here...',
      // ... existing style
    ),
  );
}
```

### Step 3: Update Contact Information

**Edit `lib/presentation/contact/controllers/contact_controller.dart`**

Replace the mock email sending with your actual API:

```dart
Future<void> sendMessage() async {
  if (!formKey.currentState!.validate()) return;

  try {
    isSending.value = true;
    
    // Replace with your email API
    // Example: EmailJS, SendGrid, Firebase Functions, etc.
    await yourEmailService.send({
      'name': nameController.text,
      'email': emailController.text,
      'subject': subjectController.text,
      'message': messageController.text,
    });
    
    messageSent.value = true;
    // ... success handling
  } catch (e) {
    // ... error handling
  }
}
```

### Step 4: Add Your Images

1. Add project screenshots to `assets/images/`
2. Add your profile photo to `assets/images/`
3. Update image references in the code

**Update hero section image:**

Edit `lib/core/constants/app_assets.dart`:
```dart
class AppAssets {
  static const String heroImage = 'assets/images/your-photo.png';
  static const String anotherImage = 'assets/images/profile.png';
}
```

### Step 5: Customize Colors (Optional)

**Edit `lib/core/constants/app_colors.dart`:**

```dart
class AppColors {
  // Your custom colors
  static const primary = Color(0xFF00D4FF);      // Change to your color
  static const neonBlue = Color(0xFF00F0FF);     // Change to your color
  static const neonPurple = Color(0xFF9D00FF);   // Change to your color
  // ... customize other colors
}
```

## 📱 Add Social Links

**Edit the navbar or footer component:**

```dart
// Add social media icons
Row(
  children: [
    IconButton(
      icon: Icon(Icons.code),  // GitHub
      onPressed: () => launch('https://github.com/yourusername'),
    ),
    IconButton(
      icon: Icon(Icons.work),  // LinkedIn
      onPressed: () => launch('https://linkedin.com/in/yourprofile'),
    ),
    IconButton(
      icon: Icon(Icons.email),  // Email
      onPressed: () => launch('mailto:your@email.com'),
    ),
  ],
)
```

## 🎬 Add Lottie Animations

### Download Animations
1. Visit [LottieFiles.com](https://lottiefiles.com/)
2. Download free animations (JSON files)
3. Create folder: `assets/lottie/`
4. Place JSON files there

### Update pubspec.yaml
Already configured! Just add your files to `assets/lottie/`

### Use in Your Code
```dart
import 'package:hamid_portfolio/presentation/widgets/lottie_animation_widget.dart';

// In your widget:
LottieAnimationWidget(
  assetPath: 'assets/lottie/your-animation.json',
  width: 300,
  height: 300,
)
```

## 🌐 Deploy Your Portfolio

### Deploy to Web

#### GitHub Pages
```bash
# Build for web
flutter build web --release

# Deploy to GitHub Pages
# (Follow GitHub Pages deployment guide)
```

#### Firebase Hosting
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login and init
firebase login
firebase init hosting

# Build and deploy
flutter build web --release
firebase deploy
```

#### Netlify
1. Build: `flutter build web --release`
2. Drag `build/web` folder to Netlify
3. Done!

### Deploy to Mobile Stores

#### Google Play Store
```bash
flutter build appbundle --release
# Upload to Play Console
```

#### Apple App Store
```bash
flutter build ios --release
# Use Xcode to upload
```

## 🎯 Pro Tips

### Performance
- ✅ Already optimized for 60fps
- ✅ Lazy loading enabled for all pages
- ✅ Optimized animation durations

### SEO (for Web)
Add to `web/index.html`:
```html
<head>
  <meta name="description" content="Your portfolio description">
  <meta name="keywords" content="Flutter, Developer, Your Name">
  <meta property="og:title" content="Your Name - Flutter Developer">
  <meta property="og:description" content="Your description">
  <meta property="og:image" content="your-image-url.png">
</head>
```

### Custom Domain
1. Deploy to hosting service
2. Add custom domain in hosting settings
3. Update DNS records

## 📚 Learn More

- **Architecture Guide**: See README.md for detailed architecture
- **Responsive Design**: Check `lib/core/utils/responsive_utils.dart`
- **Routing**: See `lib/app/routes/` for navigation setup
- **Widgets**: Browse `lib/presentation/widgets/` for reusable components

## 🆘 Common Issues

### Issue: Lottie animations not showing
**Solution**: Make sure files are in `assets/lottie/` and pubspec.yaml includes the folder

### Issue: Images not loading
**Solution**: Check `pubspec.yaml` assets section and file paths

### Issue: Navigation not working
**Solution**: Ensure all bindings are properly set up in `app_pages.dart`

### Issue: Hot reload not working
**Solution**: Use `flutter run` with hot reload (press 'r' in terminal)

## 🎉 You're All Set!

Your portfolio is now customized and ready to showcase your work!

**Next Steps:**
1. ✨ Add more projects to your repository
2. 📸 Add screenshots and demos
3. 🚀 Deploy to your hosting platform
4. 📱 Share with the world!

**Need Help?**
- Check the main README.md for detailed documentation
- Review the code comments
- Explore the example implementations

---

Happy Coding! 🚀
