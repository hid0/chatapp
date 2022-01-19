// depedencies
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/app/data/models/user_model.dart';

// route
import 'package:chatapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  // if intro skip or don't skip
  var isSkipIntro = false.obs;
  var isLoggedIn = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var userThis = UserModel().obs;

  FirebaseFirestore fstore = FirebaseFirestore.instance;

  Future<void> firstInit() async {
    /* first while running app
    and set isLoggedIn to true (autologin)
    and set isSkipIntro to true
    */
    await autoLogin().then((value) {
      if (value) {
        isLoggedIn.value = true;
      }
    });

    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
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
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        // save to firestore
        CollectionReference users = fstore.collection('users');
        // check if user login / register
        users.doc(_currentUser!.email).update({
          "lastSignin":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final thisUser = await users.doc(_currentUser!.email).get();
        // data from firebase
        final userData = thisUser.data() as Map<String, dynamic>;

        userThis(UserModel(
          uid: userData["uid"],
          name: userData["name"],
          email: userData["email"],
          photoUrl: userData["photoUrl"],
          status: userData["status"],
          createdAt: userData["createdAt"],
          lastSignin: userData["lastSignin"],
          updatedAt: userData["updatedAt"],
        ));

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
            .then((value) => userCredential = value);

        // save state user logged in & not show intro screen
        final box = GetStorage();
        if (box.read('skipIntro') != null) {
          box.remove('skipIntro');
        }
        box.write('skipIntro', true);

        // save to firestore
        CollectionReference users = fstore.collection('users');
        // check if user login / register
        final checkUser = await users.doc(_currentUser!.email).get();
        if (checkUser.data() == null) {
          users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl,
            "status": "",
            "createdAt":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignin": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedAt": DateTime.now().toIso8601String(),
          });
        } else {
          users.doc(_currentUser!.email).update({
            "lastSignin": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final thisUser = await users.doc(_currentUser!.email).get();
        // data from firebase
        final userData = thisUser.data() as Map<String, dynamic>;

        // userThis.update((val) { })

        userThis(UserModel(
          uid: userData["uid"],
          name: userData["name"],
          email: userData["email"],
          photoUrl: userData["photoUrl"],
          status: userData["status"],
          createdAt: userData["createdAt"],
          lastSignin: userData["lastSignin"],
          updatedAt: userData["updatedAt"],
        ));

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

  // profile

  void changeProfile(String name, String status) {
    String date = DateTime.now().toIso8601String();
    // update in firebase
    CollectionReference users = fstore.collection('users');
    users.doc(_currentUser!.email).update({
      "name": name,
      "status": status,
      "lastSignin":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedAt": date,
    });
    // update model
    userThis.update((user) {
      user!.name = name;
      user.status = status;
      user.lastSignin =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedAt = date;
    });

    userThis.refresh();
    Get.defaultDialog(
      title: "Success",
      middleText: "Change profile successfully!",
    );
  }

  void updateStatus(String status) {
    String date = DateTime.now().toIso8601String();
    // update in firebase
    CollectionReference users = fstore.collection('users');
    users.doc(_currentUser!.email).update({
      "status": status,
      "lastSignin":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedAt": date,
    });
    // update model
    userThis.update((user) {
      user!.status = status;
      user.lastSignin =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedAt = date;
    });

    userThis.refresh();
    Get.defaultDialog(
      title: "Success",
      middleText: "Update status successfully!",
    );
  }
}
