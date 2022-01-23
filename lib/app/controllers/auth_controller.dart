// depedencies
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/app/data/models/users_model.dart';

// route
import 'package:chatapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  // if intro skip or don't skip
  var isSkipIntro = false.obs;
  var isLoggedIn = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var userThis = UsersModel().obs;

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
        await users.doc(_currentUser!.email).update({
          "lastSignin":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final thisUser = await users.doc(_currentUser!.email).get();
        // data from firebase
        final userData = thisUser.data() as Map<String, dynamic>;

        userThis(UsersModel.fromJson(userData));

        return true;
      }
      return false;
    } catch (err) {
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
          await users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "keyName": _currentUser!.displayName!.substring(0, 1).toUpperCase(),
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl,
            "status": "",
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String(),
            "chats": [],
          });
        } else {
          await users.doc(_currentUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final thisUser = await users.doc(_currentUser!.email).get();
        // data from firebase
        final userData = thisUser.data() as Map<String, dynamic>;

        userThis(UsersModel.fromJson(userData));

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
      "keyName": name.substring(0, 1).toUpperCase(),
      "status": status,
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": date,
    });
    // update model
    userThis.update((user) {
      user!.name = name;
      user.keyName = name.substring(0, 1).toUpperCase();
      user.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
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
      "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
      "updatedTime": date,
    });
    // update model
    userThis.update((user) {
      user!.status = status;
      user.lastSignInTime =
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String();
      user.updatedTime = date;
    });

    userThis.refresh();
    Get.defaultDialog(
      title: "Success",
      middleText: "Update status successfully!",
    );
  }

  // Searching

  void addNewConnection(String email) async {
    var chat_id;
    bool flagNewConnect = false;
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = fstore.collection("chats");
    CollectionReference users = fstore.collection("users");

    final checkData = await users.doc(_currentUser!.email).get();
    final chatDocs =
        (checkData.data() as Map<String, dynamic>)['chats'] as List;

    if (chatDocs.length != 0) {
      // users has been chat with someone

      chatDocs.forEach((singleChat) {
        if (singleChat['connection'] == email) {
          chat_id = singleChat['chat_id'];
        }
      });

      if (chat_id != null) {
        // has been connected with some email
        flagNewConnect = false;
      } else {
        // not yet connected with other account
        flagNewConnect = true;
      }
    } else {
      // not yet have history chat
      flagNewConnect = true;
    }

    if (flagNewConnect) {
      final newChatDoc = await chats.add({
        "connection": [_currentUser!.email, email],
        "total_chats": 0,
        "total_read": 0,
        "total_unread": 0,
        "chats": [],
        "lastTime": date,
      });

      await users.doc(_currentUser!.email).update({
        "chats": [
          {
            "connection": email,
            "chat_id": newChatDoc.id,
            "lastTime": date,
          }
        ]
      });
      userThis.update((user) {
        user!.chats = [
          Chat(chatId: newChatDoc.id, connection: email, lastTime: date)
        ];
      });
      chat_id = newChatDoc.id;

      userThis.refresh();
    }
    print(chat_id);
    Get.toNamed(Routes.CHAT_ROOM, arguments: chat_id);
  }
}
