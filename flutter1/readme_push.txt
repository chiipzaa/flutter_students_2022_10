- https://console.firebase.google.com/
- new project

apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services'


# main.dart
-------------------
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/src/app.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const CMApp());
}




flutter pub add firebase_messaging