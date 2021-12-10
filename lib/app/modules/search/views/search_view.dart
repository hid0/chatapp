// depedencies
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// controllers & routing
import '../controllers/search_controller.dart';
import 'package:chatapp/app/routes/app_pages.dart';

class SearchView extends GetView<SearchController> {
  final List<Widget> Friends = List.generate(
    20,
    (index) => ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Image.asset('assets/logo/noimage.png'),
      ),
      title: Text(
        'Nama Chat ke-${index + 1}',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF272727),
        ),
      ),
      subtitle: Text(
        'emailorang${index + 1}@gmail.com',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xE73D3C3C),
        ),
      ),
      trailing: GestureDetector(
        onTap: () => Get.toNamed(Routes.CHAT_ROOM),
        child: Chip(
          label: Text(
            'Message',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF383838),
            ),
          ),
        ),
      ),
    ),
  );
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
            'Search',
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                controller: controller.searchController,
                cursorColor: const Color(0xE36F41EE),
                decoration: InputDecoration(
                  fillColor: const Color(0xFFE4E4E4),
                  filled: true,
                  hintText: 'Search new friends',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: const Color(0xE36F41EE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: const Color(0xE38D41EE),
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Icon(Icons.search_outlined),
                  ),
                ),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(140),
      ),
      body: Friends.length == 0
          ? Center(
              child: Container(
                width: Get.width * 0.7,
                height: Get.width * 0.7,
                child: Lottie.asset('assets/lottie/empty.json'),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: Friends.length,
              itemBuilder: (BuildContext context, int index) => Friends[index],
            ),
    );
  }
}
