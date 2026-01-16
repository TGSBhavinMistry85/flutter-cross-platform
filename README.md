# Flutter &amp; Dart
    - Desktop application

# To run the project 
    >  flutter run -d Chrome 

# Add project to GitHub Account

## Step 1️⃣ Go to your project root
    cd D:\FlutterSDK\Development\FlutterDemo\flutter_application_1

## Step 2️⃣ Initialize a new Git repository
    > git init

## Step 3️⃣ Create a proper .gitignore for Flutter
    (Flutter also provides one automatically if you used flutter create)
    If it doesn’t exist, create .gitignore and paste this: 

    # Flutter/Dart
    .dart_tool/
    .packages
    .pub/
    build/

    # IDE
    .vscode/
    .idea/
    *.iml

    # OS
    .DS_Store
    Thumbs.db

## Step 4️⃣ Add all project files
    > git add .

## Step 5️⃣ Commit the project
    > git commit -m "Initial commit"

## Step 6️⃣ Create EMPTY repo on GitHub
    On GitHub:
        Click New Repository
        Name: flutter-cross-platform
    ➡️ Repository must be completely empty

## Step 7️⃣ Add GitHub remote
    The following repository url you can get it from GitHub while performing Step 4
    git remote add origin https://github.com/TGSBhavinMistry85/flutter-cross-platform.git
    > git remote -v

## Step 8️⃣ Set branch to main
    > git branch -M main

## Step 9️⃣ Push to GitHub
    > git push -u origin main

✅ This will succeed with no errors.

# Clean & Rebuild plugins
    > flutter clean
    > flutter pub get

# Platform = Windows, Regenerate Windows files:
  Apply following command after doing "Clean & Rebuild plugins" process
    > flutter create .
    > flutter run -d windows

# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.