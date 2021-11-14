// depedencis
import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// controller & routing
import '../controllers/update_status_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
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
          title: Text(
            'Update Status',
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
            TextField(
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: const Color(0xFF161616),
                  fontSize: 18,
                ),
              ),
              decoration: InputDecoration(
                labelText: 'Status',
                floatingLabelStyle: TextStyle(color: const Color(0xE36F41EE)),
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
            Container(
              width: Get.width,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.update_outlined),
                label: Text(
                  'Update',
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
