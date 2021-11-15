// depedencies
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// controllers
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.6,
                  height: Get.width * 0.6,
                  child: Lottie.asset('assets/lottie/login.json'),
                ),
                SizedBox(height: 90),
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.HOME),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: Image.asset('assets/logo/google.png'),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Sign In with Google',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF303030),
                        ),
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFFFFFF),
                    onPrimary: const Color(0xFFC9C9C9),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shadowColor: const Color(0xFF5A5A5A),
                    maximumSize: Size(200, 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'ChatsApp \nv1.0.0',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF3D3D3D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
