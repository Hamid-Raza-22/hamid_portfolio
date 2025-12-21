# Firebase Setup Guide for Hamid Portfolio

This guide will help you set up Firebase for your dynamic portfolio project.

## Prerequisites

- Firebase CLI installed (`npm install -g firebase-tools`)
- A Google account
- Flutter SDK installed

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter a project name (e.g., "hamid-portfolio")
4. Enable/disable Google Analytics as preferred
5. Click "Create project"

## Step 2: Configure Firebase for Flutter

### Option A: Using FlutterFire CLI (Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure Firebase for your Flutter app
flutterfire configure --project=YOUR_PROJECT_ID
```

This will automatically generate the `firebase_options.dart` file.

### Option B: Manual Configuration

1. In Firebase Console, click "Add app" and select Web (for Flutter web)
2. Register your app with a nickname
3. Copy the configuration values
4. Update `lib/core/firebase/firebase_options.dart` with your values:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
  storageBucket: 'YOUR_PROJECT_ID.appspot.com',
);
```

## Step 3: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click "Get started"
3. Go to **Sign-in method** tab
4. Enable **Email/Password** authentication
5. Click "Save"

## Step 4: Set Up Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click "Create database"
3. Select **Production mode** (we'll set up proper rules)
4. Choose a Cloud Firestore location closest to your users
5. Click "Enable"

## Step 5: Deploy Security Rules

Copy the contents of `firestore.rules` to Firebase Console:

1. Go to **Firestore Database** > **Rules**
2. Replace the existing rules with the content from `firestore.rules`
3. Click "Publish"

Or deploy via CLI:

```bash
firebase deploy --only firestore:rules
```

## Step 6: Seed Initial Data

After setting up Firebase:

1. Run your Flutter app
2. Create an admin account (Sign up via the Admin panel)
3. Login to the Admin Dashboard
4. Click the menu (⋮) in the top-right corner
5. Select "Seed Initial Data"
6. This will upload all your existing static data to Firebase

## Project Structure

```
lib/
├── core/
│   ├── di/
│   │   ├── dependency_injection.dart   # Local dependencies
│   │   └── firebase_injection.dart     # Firebase dependencies
│   ├── firebase/
│   │   └── firebase_options.dart       # Firebase configuration
│   └── utils/
│       ├── icon_mapper.dart            # Icon name <-> IconData mapping
│       └── color_mapper.dart           # Color name <-> Color mapping
├── data/
│   ├── datasources/
│   │   ├── local/                      # Static local data
│   │   └── remote/
│   │       ├── firebase_datasource.dart # Firestore operations
│   │       └── auth_datasource.dart     # Auth operations
│   ├── models/                          # Firebase models with JSON serialization
│   └── repositories/
│       ├── portfolio_repository_impl.dart        # Local repository
│       ├── portfolio_repository_stream_impl.dart # Firebase repository
│       └── auth_repository_impl.dart             # Auth repository
├── domain/
│   ├── entities/                        # Domain entities
│   ├── repositories/
│   │   ├── portfolio_repository.dart         # Local interface
│   │   ├── portfolio_repository_stream.dart  # Stream interface
│   │   └── auth_repository.dart              # Auth interface
│   └── usecases/
│       ├── stream/                      # Real-time stream use cases
│       ├── admin/                       # Admin CRUD use cases
│       └── auth/                        # Authentication use cases
└── presentation/
    ├── controllers/
    │   └── admin/
    │       ├── auth_controller.dart           # Auth state management
    │       └── admin_dashboard_controller.dart # Admin CRUD operations
    ├── pages/
    │   └── admin/
    │       ├── login_page.dart          # Admin login/signup
    │       └── admin_dashboard_page.dart # Admin dashboard
    └── widgets/
        └── admin/
            └── admin_widgets.dart       # Admin UI components
```

## Firestore Collections

| Collection | Description |
|------------|-------------|
| `services` | Services offered |
| `portfolio` | Portfolio items for home page |
| `socialLinks` | Social media links |
| `stats` | Statistics (projects, clients, experience) |
| `navItems` | Navigation menu items |
| `profile` | Profile information (single document: `main`) |
| `experiences` | Work experience entries |
| `education` | Education entries |
| `certifications` | Certifications |
| `achievements` | Key achievements |
| `expertise` | Skills and expertise categories |
| `contactInfo` | Contact information |
| `projectDetails` | Detailed project information |

## Admin Panel Access

The admin panel is accessible via:
- **Admin button** in the footer of the portfolio
- Direct URL: `/admin/login`

After login, you can manage all portfolio sections through the dashboard.

## Real-Time Updates

All changes made in the admin panel are reflected instantly on the live portfolio without requiring a rebuild or redeployment. This is achieved through Firestore's real-time listeners (streams).

## Security

- **Public read access**: Anyone can view portfolio content
- **Authenticated write access**: Only logged-in admins can modify content
- **Email/Password authentication**: Simple and secure admin access

## Troubleshooting

### Firebase initialization error
- Ensure `firebase_options.dart` has correct configuration values
- Check that Firebase is initialized before runApp()

### Permission denied errors
- Verify Firestore security rules are deployed
- Ensure user is authenticated for write operations

### Data not appearing
- Use "Seed Initial Data" to populate Firebase with default content
- Check Firestore console to verify data exists

## Commands Reference

```bash
# Run the app
flutter run -d chrome

# Build for web
flutter build web

# Deploy to Firebase Hosting (optional)
firebase deploy --only hosting
```

## Support

For issues related to this portfolio implementation, please check:
1. Firebase Console for error logs
2. Flutter DevTools for app-level debugging
3. Browser console for web-specific issues
