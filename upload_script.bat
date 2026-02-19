@echo off
echo ==========================================
echo    Sign Language Project Upload Script
echo ==========================================

:: 1. Check for Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in your PATH.
    echo Please install Git from https://git-scm.com/download/win
    pause
    exit /b 1
)

:: 2. Check for Git LFS
git lfs version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Git LFS is not installed.
    echo The 'sign_language_model.h5' file is large (286MB) and requires Git LFS.
    echo Please install Git LFS from https://git-lfs.com
    echo After installing, run this script again.
    pause
    exit /b 1
)

:: 3. Initialize Repository
if not exist .git (
    echo [INFO] Initializing Git repository...
    git init
) else (
    echo [INFO] Git repository already initialized.
)

:: 4. Configure LFS and Tracking
echo [INFO] Configuring Git LFS...
git lfs install
git lfs track "*.h5"
git add .gitattributes

:: 5. Update .gitignore (remove .h5 if it was added)
if exist .gitignore (
    echo [INFO] Updating .gitignore...
    type .gitignore | findstr /v "*.h5" > .gitignore.tmp
    move /y .gitignore.tmp .gitignore >nul
)

:: 6. Stage and Commit
echo [INFO] Staging files (this may take a moment)...
git add .
echo [INFO] Committing files...
git commit -m "Upload Sign Language project with model"

:: 7. Add Remote and Push
echo [INFO] Adding remote repository...
:: Remove valid-url check for simplicity, just try to add or set-url
git remote remove origin 2>nul
git remote add origin https://github.com/kar18M/Sign-Language.git

echo [INFO] Pushing to GitHub (this might take a while for the large file)...
git branch -M main
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Push failed. Check your internet connection or GitHub credentials.
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Project uploaded successfully!
pause
