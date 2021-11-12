// depedencies
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

// controllers
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Berinteraksi dengan mudah",
            body: "Anda hanya perlu dirumah saja untuk mendapatkan teman baru.",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(
                  child: Lottie.asset('assets/lottie/main-laptop-duduk.json')),
            ),
          ),
          PageViewModel(
            title: "Dengan ChatsApp anda bisa chatting dengan teman anda",
            body: "Anda mencari namanya saja dipencarian",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(child: Lottie.asset('assets/lottie/ojek.json')),
            ),
          ),
          PageViewModel(
            title: "Chat dengan enkripsi ganda",
            body:
                "Pengenkripsian data peer2peer yang membuat chatting anda aman terkendali",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(child: Lottie.asset('assets/lottie/password.json')),
            ),
          ),
          PageViewModel(
            title: "Free",
            body: "Tentu saja gratis selama yang anda mau",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(child: Lottie.asset('assets/lottie/payment.json')),
            ),
          ),
          PageViewModel(
            title: "Join sekarang",
            body:
                "Mari gabung dengan kami, untuk terhubung dengan yang lainnya",
            image: Container(
              width: Get.width * 0.6,
              height: Get.width * 0.6,
              child: Center(child: Lottie.asset('assets/lottie/register.json')),
            ),
          ),
        ],
        onDone: () => Get.offAllNamed(Routes.LOGIN),
        showSkipButton: true,
        skip: const Icon(Icons.skip_next_outlined),
        next: const Icon(Icons.chevron_right_outlined),
        done: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
