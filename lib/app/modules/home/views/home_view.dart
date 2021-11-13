// depedencies
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// controllers
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final List<Widget> Chats = List.generate(
    20,
    (index) => ListTile(
      onTap: () => Get.toNamed(Routes.CHAT_ROOM),
      leading: CircleAvatar(
        radius: 30,
        child: Image.asset('assets/logo/noimage.png'),
      ),
      title: Text(
        'Konco Chat ke-${index + 1}',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF272727),
        ),
      ),
      subtitle: Text(
        'Isi chat konco ke-${index + 1}',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xE73D3C3C),
        ),
      ),
      trailing: Chip(
        label: Text(
          '1',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF383838),
          ),
        ),
      ),
    ),
  ).reversed.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
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
                // border: Border(
                //     bottom: BorderSide(color: const Color(0x4D383838))),
              ),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ChatsApp',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE6E6E6),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.PROFILE),
                      child: Icon(
                        Icons.person_outline_sharp,
                        size: 30,
                        color: const Color(0xFFE6E6E6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: Chats.length,
              itemBuilder: (BuildContext context, int index) => Chats[index],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(Icons.chat_outlined),
        backgroundColor: const Color(0xE38D41EE),
      ),
    );
  }
}
