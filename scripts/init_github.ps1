# GitHub Repository Initialization Script
# اس script سے آپ آسانی سے GitHub setup کر سکتے ہیں

Write-Host "🚀 GitHub Repository Initialization" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Get user information
$username = Read-Host "Enter your GitHub username (e.g., Hamid-Raza-22)"
$reponame = Read-Host "Enter repository name (e.g., hamid_portfolio)"

Write-Host ""
Write-Host "Repository will be created at:" -ForegroundColor Yellow
Write-Host "https://github.com/$username/$reponame" -ForegroundColor Green
Write-Host ""

$confirm = Read-Host "Continue? (y/n)"
if ($confirm -ne "y") {
    Write-Host "❌ Cancelled" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "📋 Step 1: Initialize Git..." -ForegroundColor Cyan

# Initialize git if not already
if (!(Test-Path ".git")) {
    git init
    Write-Host "✅ Git initialized" -ForegroundColor Green
} else {
    Write-Host "✅ Git already initialized" -ForegroundColor Green
}

Write-Host ""
Write-Host "📋 Step 2: Add remote origin..." -ForegroundColor Cyan

# Remove existing origin if any
git remote remove origin 2>$null

# Add new origin
git remote add origin "https://github.com/$username/$reponame.git"
Write-Host "✅ Remote origin added" -ForegroundColor Green

Write-Host ""
Write-Host "📋 Step 3: Stage all files..." -ForegroundColor Cyan
git add .
Write-Host "✅ Files staged" -ForegroundColor Green

Write-Host ""
Write-Host "📋 Step 4: Create initial commit..." -ForegroundColor Cyan
git commit -m "feat: Initial commit with GitHub Actions CI/CD setup"
Write-Host "✅ Commit created" -ForegroundColor Green

Write-Host ""
Write-Host "📋 Step 5: Set main branch..." -ForegroundColor Cyan
git branch -M main
Write-Host "✅ Branch set to main" -ForegroundColor Green

Write-Host ""
Write-Host "📋 Step 6: Push to GitHub..." -ForegroundColor Cyan
Write-Host "⚠️  You may need to authenticate with GitHub" -ForegroundColor Yellow
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ SUCCESS! Repository pushed to GitHub" -ForegroundColor Green
    Write-Host ""
    Write-Host "🌐 Your repository: https://github.com/$username/$reponame" -ForegroundColor Cyan
    Write-Host "🚀 GitHub Actions: https://github.com/$username/$reponame/actions" -ForegroundColor Cyan
    Write-Host "📄 Settings: https://github.com/$username/$reponame/settings/pages" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📋 Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Go to Settings → Pages" -ForegroundColor White
    Write-Host "2. Set Source to 'GitHub Actions'" -ForegroundColor White
    Write-Host "3. Wait 2-5 minutes for deployment" -ForegroundColor White
    Write-Host "4. Visit: https://$username.github.io/$reponame" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ Push failed. Please check:" -ForegroundColor Red
    Write-Host "1. Repository exists on GitHub" -ForegroundColor Yellow
    Write-Host "2. You have write access" -ForegroundColor Yellow
    Write-Host "3. Authentication is correct" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Create repository at: https://github.com/new" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Done! 🎉" -ForegroundColor Green
