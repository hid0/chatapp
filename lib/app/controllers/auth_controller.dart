// depedencies
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// route
import 'package:chatapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  // if intro skip or don't skip
  var inSkipIntro = false.obs;
  var isLoggedIn = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount? _currentUser;

  Future<void> login() async {
    // Get.offAllNamed(Routes.HOME);
    //? create login func with google
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _currentUser = value);
      await _googleSignIn.isSignedIn().then((value) {
        if (value) {
          // logged in condition
          print("Berhasil Login");
          print(_currentUser);
          isLoggedIn.value = true;
          Get.offAllNamed(Routes.HOME);
        } else {
          // failed login
          print("Gagal Login");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
