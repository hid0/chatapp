// dependencies
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// pages
import 'package:chatapp/app/utils/splash_screen.dart';
import 'package:chatapp/app/utils/loading_page.dart';
import 'package:chatapp/app/utils/error_page.dart';
import 'package:chatapp/app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // load error page
          return ErrorPage();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "ChatsApp",
                  initialRoute: AppPages.INITIAL,
                  getPages: AppPages.routes,
                );
              }
              return SplashScreen();
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        // load loading page
        return LoadingPage();
      },
    );
  }
}
