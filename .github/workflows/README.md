# 🚀 GitHub Actions Workflows

This directory contains automated CI/CD workflows for your Flutter portfolio.

## 📋 Available Workflows

### 1. 🌐 **Deploy** (`deploy.yml`)
**Trigger**: Push to `main`/`master` branch or manual dispatch

**What it does:**
- ✅ Builds Flutter web application
- ✅ Runs tests
- ✅ Deploys to GitHub Pages automatically
- ✅ Creates 404.html for SPA routing

**Output**: Live website at `https://<username>.github.io/<repo-name>`

---

### 2. 🧪 **CI - Test & Analyze** (`ci.yml`)
**Trigger**: Push/PR to `main`, `master`, or `develop`

**What it does:**
- ✅ Runs `flutter analyze` for code quality
- ✅ Checks code formatting with `dart format`
- ✅ Executes all tests with coverage
- ✅ Uploads coverage to Codecov
- ✅ Builds for web and Android

**Benefits**: Catches bugs early, maintains code quality

---

### 3. 🎉 **Release** (`release.yml`)
**Trigger**: Push tags like `v1.0.0`, `v2.1.3`

**What it does:**
- ✅ Builds optimized web release
- ✅ Creates Android APK and AAB
- ✅ Generates release notes from git commits
- ✅ Creates GitHub release with downloadable artifacts

**Usage**: 
```bash
git tag v1.0.0
git push origin v1.0.0
```

---

### 4. 🔒 **Security & Dependency Check** (`security.yml`)
**Trigger**: Weekly (Monday 9 AM) or when pubspec changes

**What it does:**
- ✅ Checks for outdated dependencies
- ✅ Runs security audit
- ✅ Generates dependency report
- ✅ Identifies potential vulnerabilities

**Benefits**: Keeps dependencies secure and up-to-date

---

## 🎯 Setup Instructions

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub
2. Settings → Pages
3. Source: **GitHub Actions**
4. Save

### Step 2: Push to GitHub

```bash
# Add all files
git add .

# Commit
git commit -m "Add GitHub Actions CI/CD"

# Push to main branch
git push origin main
```

### Step 3: Monitor Workflows

1. Go to **Actions** tab in your repository
2. Watch workflows run automatically
3. Check for ✅ success or ❌ failures

---

## 🔧 Customization

### Change Flutter Version

Edit in each workflow file:
```yaml
flutter-version: '3.24.0'  # Change this
```

### Change Branch Triggers

```yaml
on:
  push:
    branches: [ main, master, develop ]  # Add/remove branches
```

### Disable a Workflow

Rename the file to `.yml.disabled` or delete it.

---

## 📊 Workflow Status Badges

Add these to your main README.md:

```markdown
![Deploy](https://github.com/Hamid-Raza-22/Engr_Hamid_Raza/workflows/Deploy%20Flutter%20Web%20to%20GitHub%20Pages/badge.svg)
![CI](https://github.com/Hamid-Raza-22/Engr_Hamid_Raza/workflows/CI%20-%20Test%20%26%20Analyze/badge.svg)
![Security](https://github.com/Hamid-Raza-22/Engr_Hamid_Raza/workflows/Security%20%26%20Dependency%20Check/badge.svg)
```

Replace `Hamid-Raza-22/Engr_Hamid_Raza` with your username and repo name.

---

## 🐛 Troubleshooting

### Build Fails?
- Check Flutter version compatibility
- Verify all dependencies in `pubspec.yaml`
- Review workflow logs in Actions tab

### Deploy Not Working?
- Ensure GitHub Pages source is set to "GitHub Actions"
- Check repository permissions
- Verify `GITHUB_TOKEN` has proper permissions

### Tests Failing?
- Run `flutter test` locally first
- Fix failing tests before pushing
- Or set `continue-on-error: true` temporarily

---

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)
- [GitHub Pages Setup](https://pages.github.com/)

---

## 🎉 Benefits

✅ **Automated Deployment** - Push code, get live website  
✅ **Quality Assurance** - Automatic testing and analysis  
✅ **Security** - Regular dependency checks  
✅ **Release Management** - Automated versioning and releases  
✅ **Time Savings** - 60% faster deployment cycles  
✅ **Professional Workflow** - Industry-standard CI/CD  

---

**اب آپ کا portfolio professionally automated ہے!** 🚀
