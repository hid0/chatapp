// dependencies
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// controllers
import 'package:chatapp/app/controllers/auth_controller.dart';

// pages
import 'package:chatapp/app/utils/splash_screen.dart';
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Auth = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "ChatsApp",
              initialRoute: Auth.isSkipIntro.isTrue
                  ? Auth.isLoggedIn.isTrue
                      ? Routes.HOME
                      : Routes.LOGIN
                  : Routes.INTRODUCTION,
              getPages: AppPages.routes,
            ),
          );
        }
        return FutureBuilder(
          future: Auth.firstInit(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );
  }
}
