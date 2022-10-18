# warning in GradleException not found in android/app/build.gradle
  Change to :  FileNotFoundException

# multidex
- android/app/build.gradle
  defaultConfig {
          //....
          multiDexEnabled true
   }

# minSDK error in android/app/build.gradle
   minSdkVersion localProperties.getProperty('flutter.minSdkVersion')
