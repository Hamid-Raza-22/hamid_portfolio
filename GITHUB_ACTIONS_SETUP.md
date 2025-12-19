# 🚀 GitHub Actions Setup Guide

## مکمل Setup کی رہنمائی | Complete Setup Guide

---

## 📋 Pre-requisites | پہلے سے ضروری چیزیں

✅ GitHub account  
✅ Git installed locally  
✅ Repository created on GitHub  
✅ Code ready to push  

---

## 🎯 Step-by-Step Setup | قدم بہ قدم Setup

### Step 1: GitHub Repository بنائیں

```bash
# If not already created, initialize git
git init

# Add remote repository
git remote add origin https://github.com/Hamid-Raza-22/hamid_portfolio.git

# Or use SSH
git remote add origin git@github.com:Hamid-Raza-22/hamid_portfolio.git
```

---

### Step 2: GitHub Pages Enable کریں

1. اپنی repository میں جائیں
2. **Settings** → **Pages** پر click کریں
3. **Source** کو **"GitHub Actions"** select کریں
4. **Save** کریں

![GitHub Pages Setup](https://docs.github.com/assets/images/help/pages/publishing-source-drop-down.png)

---

### Step 3: Code Push کریں

```bash
# Check current status
git status

# Add all files
git add .

# Commit with message
git commit -m "feat: Add GitHub Actions CI/CD workflows"

# Push to main branch
git push origin main

# Or if using master
git push origin master
```

---

### Step 4: Workflows Check کریں

1. GitHub repository میں **Actions** tab پر جائیں
2. دیکھیں کہ workflows چل رہے ہیں:
   - ✅ Deploy Flutter Web to GitHub Pages
   - ✅ CI - Test & Analyze
3. کوئی error ہو تو logs check کریں

---

### Step 5: Live Website دیکھیں

**URL Format:**
```
https://<your-username>.github.io/<repository-name>
```

**مثال:**
```
https://Hamid-Raza-22.github.io/hamid_portfolio
```

⏰ **Note**: First deployment میں 2-5 منٹ لگ سکتے ہیں۔

---

## 🔧 Workflows Overview

### 1️⃣ Deploy Workflow (deploy.yml)

**کب چلتا ہے:**
- `main` یا `master` branch پر push کرنے پر
- Manually trigger کر سکتے ہیں

**کیا کرتا ہے:**
1. Flutter install کرتا ہے
2. Dependencies download کرتا ہے
3. Tests run کرتا ہے
4. Web build بناتا ہے
5. GitHub Pages پر deploy کرتا ہے

**Result:** آپ کی website live ہو جاتی ہے! 🎉

---

### 2️⃣ CI Workflow (ci.yml)

**کب چلتا ہے:**
- ہر push/PR پر
- Multiple branches support کرتا ہے

**کیا کرتا ہے:**
1. Code analyze کرتا ہے
2. Formatting check کرتا ہے
3. Tests run کرتا ہے
4. Coverage report بناتا ہے
5. Web اور Android builds test کرتا ہے

**Result:** Code quality maintain رہتی ہے! ✅

---

### 3️⃣ Release Workflow (release.yml)

**کب چلتا ہے:**
- جب version tag push کریں (e.g., `v1.0.0`)

**کیا کرتا ہے:**
1. Production builds بناتا ہے
2. Release notes generate کرتا ہے
3. Downloadable files بناتا ہے
4. GitHub Release create کرتا ہے

**استعمال:**
```bash
# Create a tag
git tag v1.0.0

# Push the tag
git push origin v1.0.0

# Release automatically create ہو جائے گی!
```

---

### 4️⃣ Security Workflow (security.yml)

**کب چلتا ہے:**
- ہر Monday صبح 9 بجے (automatic)
- `pubspec.yaml` تبدیل ہونے پر

**کیا کرتا ہے:**
1. Dependencies check کرتا ہے
2. Outdated packages find کرتا ہے
3. Security vulnerabilities check کرتا ہے
4. Report generate کرتا ہے

**Result:** آپ کا app secure رہتا ہے! 🔒

---

## 📊 Status Badges Add کریں

اپنی main `README.md` میں یہ badges add کریں:

```markdown
# Hamid Raza - Portfolio

![Deploy](https://github.com/Hamid-Raza-22/hamid_portfolio/workflows/Deploy%20Flutter%20Web%20to%20GitHub%20Pages/badge.svg)
![CI](https://github.com/Hamid-Raza-22/hamid_portfolio/workflows/CI%20-%20Test%20%26%20Analyze/badge.svg)
![Release](https://github.com/Hamid-Raza-22/hamid_portfolio/workflows/Release/badge.svg)
![Security](https://github.com/Hamid-Raza-22/hamid_portfolio/workflows/Security%20%26%20Dependency%20Check/badge.svg)

🌐 **Live Demo**: https://Hamid-Raza-22.github.io/hamid_portfolio
```

یہ badges automatically update ہوتے ہیں! 📈

---

## 🎛️ Advanced Configuration

### Custom Domain Setup

1. Repository → Settings → Pages
2. **Custom domain** field میں اپنا domain add کریں
3. DNS میں CNAME record add کریں:
   ```
   CNAME: your-domain.com → hamid-raza-22.github.io
   ```

### Secrets Add کریں

اگر API keys وغیرہ use کر رہے ہیں:

1. Repository → Settings → Secrets and variables → Actions
2. **New repository secret** click کریں
3. Name اور value enter کریں
4. Workflow میں use کریں:
   ```yaml
   env:
     API_KEY: ${{ secrets.API_KEY }}
   ```

### Environments Setup

Production, Staging environments کے لیے:

1. Repository → Settings → Environments
2. **New environment** بنائیں
3. Protection rules add کریں
4. Workflow میں use کریں:
   ```yaml
   environment:
     name: production
   ```

---

## 🐛 Common Issues & Solutions

### ❌ Build Fail ہو رہا ہے

**Problem**: Dependencies resolve نہیں ہو رہیں

**Solution**:
```bash
# Locally check کریں
flutter pub get
flutter build web
```

اگر locally چل رہا ہے تو workflow میں Flutter version check کریں۔

---

### ❌ Tests Fail ہو رہے ہیں

**Problem**: Test cases fail ہو رہے ہیں

**Solution**:
```bash
# Tests locally run کریں
flutter test

# Failed tests fix کریں
# یا temporarily disable کریں workflow میں:
continue-on-error: true
```

---

### ❌ Pages Deploy نہیں ہو رہے

**Problem**: GitHub Pages settings غلط ہیں

**Solution**:
1. Settings → Pages check کریں
2. Source: **GitHub Actions** ہونا چاہیے
3. Repository public ہونی چاہیے (یا Pro account)

---

### ❌ Permission Errors

**Problem**: `GITHUB_TOKEN` permissions نہیں ہیں

**Solution**: Workflow میں permissions add کریں:
```yaml
permissions:
  contents: read
  pages: write
  id-token: write
```

---

## 📈 Monitoring & Insights

### Workflow Runs دیکھیں

1. **Actions** tab
2. کوئی بھی workflow select کریں
3. Run history دیکھیں
4. Logs تفصیل سے check کریں

### Email Notifications

GitHub automatically emails بھیجتا ہے اگر:
- ❌ Workflow fail ہو
- ✅ پہلے failed تھا، اب pass ہو گیا

Settings میں customize کر سکتے ہیں۔

---

## 🎯 Best Practices

### 1. Commit Messages

Use conventional commits:
```bash
git commit -m "feat: Add new feature"
git commit -m "fix: Resolve bug"
git commit -m "docs: Update documentation"
git commit -m "ci: Update workflow"
```

### 2. Branch Strategy

```
main/master   → Production (auto-deploy)
develop       → Development (CI only)
feature/*     → Feature branches
hotfix/*      → Emergency fixes
```

### 3. Version Tagging

Semantic versioning use کریں:
```
v1.0.0 → Major release
v1.1.0 → Minor update
v1.0.1 → Patch/bugfix
```

### 4. Keep Workflows Updated

```bash
# Monthly check کریں:
- Flutter version updates
- Action versions (v3 → v4)
- Dependencies security patches
```

---

## 🚀 Deployment Checklist

قبل از Deployment یہ check کریں:

- [ ] All tests passing ہیں
- [ ] Code analyzed ہے (no warnings)
- [ ] Assets properly configured ہیں
- [ ] Environment variables set ہیں
- [ ] Base href correct ہے (web)
- [ ] GitHub Pages enabled ہے
- [ ] Custom domain configured ہے (optional)

---

## 📚 Resources

### Official Documentation
- [GitHub Actions Docs](https://docs.github.com/actions)
- [Flutter CI/CD](https://docs.flutter.dev/deployment/cd)
- [GitHub Pages Guide](https://pages.github.com/)

### Helpful Links
- [Flutter GitHub Actions](https://github.com/marketplace/actions/flutter-action)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

### Community
- [Flutter Discord](https://discord.gg/flutter)
- [GitHub Community](https://github.community)

---

## 🎉 Success Metrics

اب آپ کے پاس ہے:

✅ **Automated Deployment** - 30 منٹ سے 3 منٹ  
✅ **Quality Assurance** - ہر commit پر automatic testing  
✅ **Security Monitoring** - Weekly vulnerability checks  
✅ **Release Management** - One-command releases  
✅ **Professional Workflow** - Industry-standard practices  

---

## 💡 Next Steps

1. ✅ GitHub Actions workflows add کریں
2. ✅ Code push کریں
3. ✅ Workflows monitor کریں
4. ✅ Live website verify کریں
5. 🎯 Custom domain add کریں (optional)
6. 📊 Analytics integrate کریں (Google Analytics)
7. 🔒 SSL certificate verify کریں (automatic on GitHub Pages)

---

**اب آپ کا portfolio professionally deployed ہے!** 🚀✨

**Questions?** Open an issue یا discussion start کریں!
