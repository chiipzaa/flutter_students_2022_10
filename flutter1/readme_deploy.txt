cd android
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key


# rename pacakge both Android and iOS
1. change_app_package_name in dev dependencies
2. flutter pub run change_app_package_name:main com.xxx.xx
3. Clean and Run (check Android Manifest and Info.plist)
- https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html

flutter pub add flutter_launcher_icons
flutter pub run flutter_launcher_icons:main
flutter run --release

flutter build apk
flutter build appbundle

# Android (certification)
-----------------

# Add android/key.properties
    storePassword=12341234
    keyPassword=12341234
    keyAlias=key
    storeFile=/........./android/key.jks

#Update android/app/build.gradle
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }

