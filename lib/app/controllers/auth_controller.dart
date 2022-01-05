// depedencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

// route
import 'package:chatapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  // if intro skip or don't skip
  var isSkipIntro = false.obs;
  var isLoggedIn = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? user;

  FirebaseFirestore fstore = FirebaseFirestore.instance;

  Future<void> firstInit() async {
    /* first while running app
    and set isLoggedIn to true (autologin)
    and set isSkipIntro to true
    */
    await autoLogin().then((value) => value ? isLoggedIn.value = true : null);

    await skipIntro().then((value) => value ? isSkipIntro.value = true : null);
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipIntro') != null || box.read('skipIntro') == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        // isLoggedIn.value = true;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

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

        // save state user logged in & not show intro screen
        final box = GetStorage();
        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);

        // save to firestore
        CollectionReference users = fstore.collection('users');
        users.doc(_currentUser!.email).set({
          "uid": user!.user!.uid,
          "nama": _currentUser!.displayName,
          "email": _currentUser!.email,
          "photoUrl": _currentUser!.photoUrl,
          "status": "",
          "created_at": user!.user!.metadata.creationTime!.toIso8601String(),
          "last_signin": user!.user!.metadata.lastSignInTime!.toIso8601String(),
          "updated_at": DateTime.now().toIso8601String(),
        });

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
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
