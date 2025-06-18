// assets.dart

class AppAssets {
  // Prevent instantiation
  AppAssets._();

  // ----- IMAGES -----
  static const String _imagesBasePath = 'assets/images';
  static const String heroImagePath = '$_imagesBasePath/your_hero_image.png'; // <-- MAKE SURE THIS FILENAME IS CORRECT
  static const String anotherImage = '$_imagesBasePath/another_image.png'; // Example
// Add more image paths here...

// ----- ICONS -----
// static const String _iconsBasePath = 'assets/icons';
// static const String myCustomIcon = '$_iconsBasePath/custom_icon.svg';
// Add more icon paths here...

// ----- ANIMATIONS / LOTTIE FILES -----
// static const String _animationsBasePath = 'assets/animations';
// static const String loadingAnimation = '$_animationsBasePath/loader.json';
// Add more animation paths here...

// ----- FONTS (Names defined in pubspec.yaml) -----
// static const String primaryFontFamily = 'Poppins';
}