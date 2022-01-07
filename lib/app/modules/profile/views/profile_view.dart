// dependencies
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatapp/app/routes/app_pages.dart';

// controllers
import '../controllers/profile_controller.dart';
import 'package:chatapp/app/controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final Auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () => Auth.logout(),
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                const Color(0xE36F41EE),
                const Color(0xE38D41EE),
                const Color(0xE3D641EE)
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                AvatarGlow(
                  endRadius: 110,
                  glowColor: Colors.black87,
                  duration: Duration(seconds: 2),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    width: 160,
                    height: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Auth.userThis.photoUrl == null
                          ? Image.asset(
                              'assets/logo/noimage.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              Auth.userThis.photoUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Text(
                  "${Auth.userThis.name}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C2B2B),
                  ),
                ),
                Text(
                  "${Auth.userThis.email}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF363636),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Get.toNamed(Routes.UPDATE_STATUS),
                    leading: Icon(Icons.note_add_outlined, size: 30),
                    title: Text(
                      'Update Status',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D3D3D),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    leading: Icon(Icons.person_outline_rounded, size: 30),
                    title: Text(
                      'Change Profile',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D3D3D),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.color_lens_outlined, size: 30),
                    title: Text(
                      'Change Theme',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D3D3D),
                      ),
                    ),
                    trailing: Icon(Icons.light_mode_outlined),
                    // trailing: Icon(Icons.dark_mode_outlined),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              'ChatsApp \nv1.0.0',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4D4D4D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
