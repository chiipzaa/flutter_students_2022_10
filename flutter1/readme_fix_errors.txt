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


# fix certification error
https://stackoverflow.com/questions/70536488/flutter-dio-https-certificate-validation-ignoring-onbadcertificate-ca-cert-pro

//check bad certificate
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
    };