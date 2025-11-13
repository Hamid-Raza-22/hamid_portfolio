# 📁 Assets Guide

This folder contains all static assets for your portfolio.

## 📂 Folder Structure

```
assets/
├── images/          # Photos, screenshots, logos
├── lottie/          # Lottie animation files (.json)
└── ASSETS_README.md # This file
```

## 🖼️ Images Needed

### Required Images

1. **Profile Photo** (`your-photo.png`)
   - Recommended size: 400x400px
   - Format: PNG with transparent background
   - Use: Hero section, About page

2. **Profile Picture** (`profile.png`)
   - Recommended size: 300x300px
   - Format: PNG or JPG
   - Use: Alternative profile image

### Project Screenshots

Add screenshots for each project:
- `project1.png` - First project screenshot
- `project2.png` - Second project screenshot
- `project3.png` - Third project screenshot
- etc.

**Recommended Specifications:**
- Size: 1200x800px or 16:9 aspect ratio
- Format: PNG or JPG
- Quality: High resolution for retina displays
- Optimize: Use tools like TinyPNG to reduce file size

### Optional Images

- **Logo** (`logo.png`) - Your personal brand logo
- **Favicon** (`favicon.ico`) - For web deployment
- **OG Image** (`og-image.png`) - Social media preview (1200x630px)

## 🎬 Lottie Animations

Lottie animations enhance the visual appeal of your portfolio.

### Where to Get Lottie Files

1. **[LottieFiles.com](https://lottiefiles.com/)** - Free animations
2. **[LordIcon.com](https://lordicon.com/)** - Icon animations
3. **[Icons8 Animated Icons](https://icons8.com/animated-icons)** - Various animations

### Recommended Animations

Download these types of animations:

1. **ai_background.json** - AI/Tech background animation
   - Search: "AI", "Network", "Particles"
   - Use: Background effects

2. **coding.json** - Coding/development animation
   - Search: "Coding", "Programming", "Developer"
   - Use: Skills section

3. **data_visualization.json** - Data visualization
   - Search: "Data", "Charts", "Analytics"
   - Use: Projects section

4. **loading.json** - Loading spinner
   - Search: "Loading", "Spinner", "Progress"
   - Use: Loading states

5. **success.json** - Success checkmark
   - Search: "Success", "Check", "Complete"
   - Use: Form submission feedback

6. **particle_network.json** - Particle network
   - Search: "Network", "Connections", "Nodes"
   - Use: Background decoration

7. **circuit_board.json** - Circuit board pattern
   - Search: "Circuit", "Technology", "Microchip"
   - Use: Tech-themed backgrounds

8. **skill_progress.json** - Progress animation
   - Search: "Progress", "Loading bar", "Percentage"
   - Use: Skills progress bars

### How to Add Lottie Animations

1. Download JSON file from LottieFiles
2. Place in `assets/lottie/` folder
3. Reference in your code:

```dart
import 'package:hamid_portfolio/presentation/widgets/lottie_animation_widget.dart';

LottieAnimationWidget(
  assetPath: 'assets/lottie/your-animation.json',
  width: 300,
  height: 300,
)
```

## 📐 Image Guidelines

### Format Recommendations

| Image Type | Format | Size | Notes |
|------------|--------|------|-------|
| Profile Photos | PNG | 400x400px | Transparent background |
| Project Screenshots | PNG/JPG | 1200x800px | High quality |
| Logo | PNG/SVG | 200x200px | Vector preferred |
| Favicon | ICO | 32x32px | For web |
| OG Image | PNG/JPG | 1200x630px | Social sharing |

### Optimization Tips

1. **Compress Images**
   - Use [TinyPNG](https://tinypng.com/) or [Squoosh](https://squoosh.app/)
   - Target: < 200KB per image
   - Maintain quality while reducing size

2. **Use Appropriate Formats**
   - PNG: Logos, icons, transparency needed
   - JPG: Photos, screenshots, no transparency
   - SVG: Logos, icons (scalable)

3. **Responsive Images**
   - Provide 1x, 2x, 3x versions for mobile
   - Or use high-res and let Flutter scale down

4. **Lazy Loading**
   - Already implemented in the app
   - Images load on-demand

## 🎨 Creating Assets

### Profile Photo Tips

1. **Professional Look**
   - Good lighting
   - Clean background
   - Professional attire
   - Genuine smile

2. **Remove Background**
   - Use [Remove.bg](https://www.remove.bg/)
   - Or Photoshop/GIMP
   - Save as PNG with transparency

3. **Optimize Size**
   - 400x400px is ideal
   - Square aspect ratio
   - High quality but compressed

### Project Screenshots

1. **Capture Best Moments**
   - Show key features
   - Use actual app screenshots
   - Multiple screens if needed

2. **Add Context**
   - Include UI elements
   - Show user interactions
   - Highlight unique features

3. **Mockups (Optional)**
   - Use [Mockuuups](https://mockuuups.studio/)
   - Or [Smartmockups](https://smartmockups.com/)
   - Add device frames

## 🔄 Asset Updates

### When Adding New Projects

1. Add project screenshot to `assets/images/`
2. Update project model in repository
3. Reference new image path

### When Changing Profile Photo

1. Replace existing image file
2. Or update path in `app_assets.dart`
3. Hot reload to see changes

## 📊 Asset Checklist

Before deployment, ensure you have:

- [ ] Profile photo (PNG)
- [ ] At least 3 project screenshots
- [ ] Logo (optional)
- [ ] Favicon for web
- [ ] OG image for social sharing
- [ ] 2-3 Lottie animations
- [ ] All images optimized (< 200KB each)
- [ ] All paths correctly referenced in code

## 🚀 Performance Tips

1. **Lazy Load Large Images**
   - Already implemented
   - Images load when visible

2. **Use Appropriate Sizes**
   - Don't use 4K images for thumbnails
   - Resize images to actual display size

3. **Cache Strategy**
   - Flutter caches images automatically
   - Consider using `cached_network_image` for remote images

4. **Lottie Optimization**
   - Keep animations under 100KB
   - Use simple animations
   - Limit number of simultaneous animations

## 📝 Notes

- All assets should be committed to Git (unless very large)
- Keep backup of original high-res assets
- Document custom assets and their sources
- Update this README when adding new asset types

---

Need help? Check the main README.md or QUICKSTART.md
