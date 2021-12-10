import 'package:chatapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // if intro skip or don't skip
  var inSkipIntro = false.obs;
  var isLoggedIn = false.obs;

  void login() {
    Get.offAllNamed(Routes.HOME);
  }

  void logout() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
