// depedencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// route
import 'package:chatapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  // if intro skip or don't skip
  var inSkipIntro = false.obs;
  var isLoggedIn = false.obs;
  UserCredential? user;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount? _currentUser;

  Future<void> login() async {
    try {
      // handle data leak
      await _googleSignIn.signOut();

      // get account of google
      await _googleSignIn.signIn().then((value) => _currentUser = value);

      // check condition
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => user = value);

        isLoggedIn.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        print("Gagal Login");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
