# Install jdk from android studio
- new flutter project
- open product structure
- select sdk and click + jdk
- download
- set jre location (java and keytool)

remove comments
//.*

// IOS
podfile
platform :ios, '10.0'

https://www.youtube.com/watch?v=jpcNpaSrLig
flutter run --release

cd android
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key


# rename pacakge both Android and iOS
1. change_app_package_name in dev dependencies
2. flutter pub run change_app_package_name:main com.xxx.xx
3. Clean and Run (check Android Manifest and Info.plist)



flutter pub run flutter_launcher_icons:main
flutter run --release

flutter build apk
flutter build appbundle


connect android adb via wifi
-----------------------------
adb devices
adb tcpip 5555
adb shell ip addr show wlan0
adb connect 192.168.0.114


flutter build appbundle -v

# Fix [Solved] Mapping new ns to old ns Flutter [Solved]
# Upgrade gradle
classpath 'com.android.tools.build:gradle:7.1.1'
gradle-wrapper.properties distributionUrl=https\://services.gradle.org/distributions/gradle-7.2-all.zip
uses-sdk:minSdkVersion 16 cannot be smaller than version 20 declared in library

# Fix
open /build.gradle
ext.kotlin_version = '1.5.10'
classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"

# Android proxy
https://medium.com/@indaniram/run-android-emulator-with-proxy-configurations-6586ecb5461d

# Gradle build with proxy
/home/<username>/.gradle/ (Linux)
/Users/<username>/.gradle/ (Mac)
C:\Users\<username>\.gradle (Windows)

This is my gradle.properties, please note those HTTPS portion
systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=8118
systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=8118

------------------------------------
# Flutter Plugins
-----------------------
- Flutter
- Fluter Enhancement Suite
- FlutterAsstAutoCompl
- Bloc
- Dart
- Flutter JsonBeanFactory (ruiyu)
- ADB WI-Fi (Yury Polek)
- JsonToDart (JSON to Dart) Anti Mahadik

# pubspec
-----------------------
flutter pub add font_awesome_flutter
flutter pub add shared_preferences
flutter pub add badges
flutter pub add dio
flutter pub add image_picker
flutter pub add another_flushbar
flutter pub add image_cropper
flutter pub add google_maps_flutter
flutter pub add maps_toolkit
flutter pub add url_launcher
flutter pub add intl
flutter pub add flutter_bloc
flutter pub add equatable
flutter pub add rxdart
flutter pub add qr_flutter
flutter pub add onesignal_flutter
flutter pub add logger
flutter pub add location
flutter pub add qr_code_scanner

# pubspec
-----------------------
font_awesome_flutter: ^9.1.0
shared_preferences: ^2.0.6
badges: ^2.0.1
dio: ^4.0.0
image_picker: ^0.8.4+2
another_flushbar: ^1.10.24
image_cropper: ^1.4.1
google_maps_flutter: ^2.0.6
maps_toolkit: ^2.0.0
url_launcher: ^6.0.9
intl: ^0.17.0
flutter_bloc: ^8.0.0
equatable: ^2.0.0
rxdart: ^0.27.2
qr_flutter: ^4.0.0
onesignal_flutter: ^3.3.0
logger: ^1.1.0
location:
git:
  url: https://github.com/Yczar/flutterlocation.git
  path: packages/location
qr_code_scanner:
  git:
    url: https://github.com/xeinebiu/qr_code_scanner.git
    ref: fix_break_changes_platform
barcode_widget: ^2.0.1