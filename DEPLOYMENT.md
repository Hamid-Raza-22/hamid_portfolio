# 🚀 Deployment Guide

Complete guide to deploy your Flutter portfolio to various platforms.

## 📑 Table of Contents

- [Web Deployment](#-web-deployment)
- [Mobile Deployment](#-mobile-deployment)
- [Desktop Deployment](#-desktop-deployment)
- [CI/CD Setup](#-cicd-setup)

---

## 🌐 Web Deployment

### Option 1: GitHub Pages (Free)

**Prerequisites:**
- GitHub account
- Repository created

**Steps:**

1. **Build for web:**
```bash
flutter build web --release --base-href "/your-repo-name/"
```

2. **Create gh-pages branch:**
```bash
git checkout -b gh-pages
```

3. **Copy build files:**
```bash
cp -r build/web/* .
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages
```

4. **Enable GitHub Pages:**
- Go to repository Settings
- Pages section
- Source: gh-pages branch
- Save

**Your site:** `https://yourusername.github.io/your-repo-name/`

**Custom Domain (Optional):**
1. Add CNAME file to `web/` folder
2. Configure DNS with your provider
3. Enable custom domain in GitHub Pages settings

---

### Option 2: Firebase Hosting (Free Tier)

**Prerequisites:**
- Firebase account
- Firebase CLI installed

**Steps:**

1. **Install Firebase CLI:**
```bash
npm install -g firebase-tools
```

2. **Login to Firebase:**
```bash
firebase login
```

3. **Initialize Firebase:**
```bash
firebase init hosting
```

Select:
- Existing project or create new
- Public directory: `build/web`
- Single-page app: Yes
- GitHub auto-deploy: Optional

4. **Build and deploy:**
```bash
flutter build web --release
firebase deploy
```

**Your site:** `https://your-project.web.app`

**Custom Domain:**
```bash
firebase hosting:channel:deploy production --expires 30d
```

Then add domain in Firebase Console.

---

### Option 3: Netlify (Free Tier)

**Method 1: Drag and Drop**

1. Build your app:
```bash
flutter build web --release
```

2. Go to [Netlify](https://www.netlify.com/)
3. Drag `build/web` folder to Netlify
4. Done!

**Method 2: Git Integration**

1. Connect your GitHub repository
2. Configure build settings:
   - Build command: `flutter build web --release`
   - Publish directory: `build/web`
3. Deploy!

**Custom Domain:**
- Netlify Settings → Domain Management
- Add custom domain
- Configure DNS

---

### Option 4: Vercel (Free)

**Steps:**

1. Install Vercel CLI:
```bash
npm i -g vercel
```

2. Build your app:
```bash
flutter build web --release
```

3. Deploy:
```bash
cd build/web
vercel
```

**Or connect via Git:**
- Link your repository
- Configure build: `flutter build web --release`
- Output: `build/web`

---

## 📱 Mobile Deployment

### Android (Google Play Store)

**Prerequisites:**
- Google Play Console account ($25 one-time fee)
- Android keystore file

**1. Create Keystore:**

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**2. Configure key.properties:**

Create `android/key.properties`:
```properties
storePassword=your-store-password
keyPassword=your-key-password
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

**3. Update build.gradle:**

Already configured! Check `android/app/build.gradle`

**4. Build APK/App Bundle:**

```bash
# App Bundle (Recommended)
flutter build appbundle --release

# APK
flutter build apk --release --split-per-abi
```

**5. Upload to Play Console:**
- Create app in Play Console
- Upload `build/app/outputs/bundle/release/app-release.aab`
- Fill in store listing, content rating, etc.
- Submit for review

---

### iOS (Apple App Store)

**Prerequisites:**
- Apple Developer account ($99/year)
- Xcode installed (macOS only)
- App Store Connect account

**Steps:**

1. **Open iOS project in Xcode:**
```bash
open ios/Runner.xcworkspace
```

2. **Configure signing:**
- Select Runner in project navigator
- Signing & Capabilities
- Team: Your Apple Developer team
- Bundle Identifier: Your unique ID

3. **Update version:**
```bash
# Update pubspec.yaml version
version: 1.0.0+1
```

4. **Build archive:**
```bash
flutter build ios --release
```

5. **Archive in Xcode:**
- Product → Archive
- Distribute App
- App Store Connect
- Upload

6. **Submit via App Store Connect:**
- Fill in app information
- Add screenshots
- Submit for review

---

## 💻 Desktop Deployment

### Windows

**Build:**
```bash
flutter build windows --release
```

**Output:** `build/windows/runner/Release/`

**Distribution Options:**
1. **Direct download** - Zip the folder
2. **Installer** - Use Inno Setup or NSIS
3. **Microsoft Store** - Submit via Partner Center

**Create Installer (Inno Setup):**
1. Download [Inno Setup](https://jrsoftware.org/isinfo.php)
2. Create script:
```iss
[Setup]
AppName=Your Portfolio
AppVersion=1.0
DefaultDirName={pf}\YourPortfolio
DefaultGroupName=Your Portfolio
OutputDir=installer
OutputBaseFilename=portfolio-setup

[Files]
Source: "build\windows\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs
```

---

### macOS

**Build:**
```bash
flutter build macos --release
```

**Output:** `build/macos/Build/Products/Release/`

**Distribution:**
1. **DMG** - Create disk image
2. **App Store** - Submit via App Store Connect
3. **Direct download** - Notarize with Apple

**Create DMG:**
```bash
# Use create-dmg tool
npm install --global create-dmg
create-dmg build/macos/Build/Products/Release/YourApp.app
```

---

### Linux

**Build:**
```bash
flutter build linux --release
```

**Output:** `build/linux/x64/release/bundle/`

**Distribution:**
1. **AppImage** - Portable format
2. **Snap** - Ubuntu Software Center
3. **Flatpak** - Cross-distribution
4. **DEB/RPM** - Package managers

---

## 🔄 CI/CD Setup

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy Portfolio

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.8.1'
    
    - name: Install dependencies
      run: flutter pub get
    
    - name: Build web
      run: flutter build web --release
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./build/web
```

---

### Firebase CI/CD

1. **Generate Firebase token:**
```bash
firebase login:ci
```

2. **Add to GitHub Secrets:**
- FIREBASE_TOKEN

3. **Update workflow:**
```yaml
- name: Deploy to Firebase
  run: |
    npm install -g firebase-tools
    firebase deploy --token ${{ secrets.FIREBASE_TOKEN }}
```

---

## 📋 Pre-Deployment Checklist

### General
- [ ] Update version number in `pubspec.yaml`
- [ ] Test on all target platforms
- [ ] Optimize images (< 200KB each)
- [ ] Remove debug code and print statements
- [ ] Update README with deployment URL

### Web
- [ ] Configure SEO meta tags in `web/index.html`
- [ ] Add favicon and OG images
- [ ] Test on multiple browsers
- [ ] Configure analytics (optional)
- [ ] Set up custom domain (if applicable)

### Mobile
- [ ] Create store listings and screenshots
- [ ] Add privacy policy URL
- [ ] Configure app signing
- [ ] Test on physical devices
- [ ] Prepare promotional materials

### Performance
- [ ] Run performance profiling
- [ ] Check bundle size
- [ ] Test loading times
- [ ] Verify 60fps animations
- [ ] Test on slow networks

---

## 🐛 Common Deployment Issues

### Web: Blank screen after deployment
**Solution:** Check base-href in build command matches deployment path

### Android: Upload failed
**Solution:** Ensure you're using app bundle, not APK for Play Store

### iOS: Build failed
**Solution:** Run `pod install` in ios folder, clean build folder

### All platforms: Assets not loading
**Solution:** Verify all assets are properly declared in `pubspec.yaml`

---

## 📊 Post-Deployment

### Monitor Your App

1. **Analytics:**
   - Google Analytics
   - Firebase Analytics
   - Mixpanel

2. **Performance:**
   - Firebase Performance Monitoring
   - Sentry for error tracking
   - Lighthouse for web performance

3. **User Feedback:**
   - In-app feedback forms
   - Store reviews monitoring
   - Contact form submissions

### Update Process

1. Increment version in `pubspec.yaml`
2. Make your changes
3. Test thoroughly
4. Build for platform
5. Deploy/Submit update
6. Monitor for issues

---

## 🎉 Success!

Your portfolio is now live! Share it with:
- LinkedIn profile
- GitHub README
- Resume/CV
- Job applications
- Social media

**Next Steps:**
- Set up analytics
- Monitor performance
- Gather user feedback
- Plan next features
- Keep content updated

Need help? Check the main README.md or open an issue on GitHub.

---

**Happy Deploying! 🚀**
