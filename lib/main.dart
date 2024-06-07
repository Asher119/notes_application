import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_taking_app/Screens/SplashScereen.dart';


void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAaXEzRsERy-MICxH8Q9YVIewOvfsvD6ao",
      appId: "1:86061198868:android:10a3c9926918d9f25bc101",
      messagingSenderId: "86061198868",
      projectId: "notes-4b8f1.appspot.com",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white, scaffoldBackgroundColor: Color(0xff070706)),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
