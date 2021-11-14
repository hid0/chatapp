// depedencies
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// controller & routing
import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        child: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.save_outlined),
            ),
          ],
          title: Text(
            'Change Profile',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFCFCFC),
            ),
          ),
          centerTitle: true,
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
        preferredSize: Size.fromHeight(56),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // image container for show image of account
            Container(
              // margin: EdgeInsets.all(30),
              margin: EdgeInsets.fromLTRB(0, 30, 0, 50),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage('assets/logo/noimage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // form of biodata & image upload
            Container(
              child: Column(
                children: [
                  // email form
                  TextField(
                    controller: controller.emailController,
                    readOnly: true,
                    cursorColor: const Color(0xFF5C35C7),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: const Color(0xFF161616),
                        fontSize: 18,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      floatingLabelStyle:
                          TextStyle(color: const Color(0xE36F41EE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xE36F41EE)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color(0x6E8C41EE),
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // name form
                  TextField(
                    controller: controller.nameController,
                    cursorColor: const Color(0xFF5C35C7),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: const Color(0xFF161616),
                        fontSize: 18,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      floatingLabelStyle:
                          TextStyle(color: const Color(0xE36F41EE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xE36F41EE)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color(0x6E8C41EE),
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // status form
                  TextField(
                    controller: controller.statusController,
                    cursorColor: const Color(0xFF5C35C7),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: const Color(0xFF161616),
                        fontSize: 18,
                      ),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Status',
                      floatingLabelStyle:
                          TextStyle(color: const Color(0xE36F41EE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: const Color(0xE36F41EE)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color(0x6E8C41EE),
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // upload image form
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'no image',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF525252),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Choose...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF383838),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            // button update
            Container(
              width: Get.width,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.update_outlined),
                label: Text(
                  'Update Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF8C41EE),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shadowColor: const Color(0xFF5A5A5A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
