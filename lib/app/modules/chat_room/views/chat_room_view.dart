// depedencies
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// controllers & routing
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          leadingWidth: 90,
          leading: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5),
                Icon(Icons.arrow_back_ios_new_outlined),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/logo/noimage.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Temen Chat',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Text(
                'Statusnya',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFE0E0E0),
                ),
              ),
            ],
          ),
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
      body: WillPopScope(
        onWillPop: () {
          if (controller.isShowEmoji.isTrue) {
            controller.isShowEmoji.value = false;
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    ItemChat(isSender: true),
                    ItemChat(isSender: false),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // chat input
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: controller.chatController,
                        cursorColor: const Color(0xFF5C35C7),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: const Color(0xFF161616),
                            fontSize: 16,
                          ),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Message',
                          prefixIcon: IconButton(
                            onPressed: () {
                              controller.focusNode.unfocus();
                              controller.isShowEmoji.toggle();
                            },
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: const Color(0x8F6F41EE),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                BorderSide(color: const Color(0xE36F41EE)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: const Color(0x6E8C41EE),
                              width: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  // button send
                  Material(
                    color: const Color(0xFF511FDB),
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          Icons.send_outlined,
                          color: const Color(0xFFF1F1F1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => (controller.isShowEmoji.isTrue)
                  ? Container(
                      height: 325,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          // Do something when emoji is tapped
                          controller.addEmoToInput(emoji);
                        },
                        onBackspacePressed: () {
                          // Backspace-Button tapped logic
                          // Remove this line to also remove the button in the UI
                          controller.delEmo();
                        },
                        config: Config(
                          columns: 7,
                          emojiSizeMax: 32 *
                              (Platform.isIOS
                                  ? 1.30
                                  : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          progressIndicatorColor: Colors.blue,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: "No Recents",
                          noRecentsStyle: const TextStyle(
                              fontSize: 20, color: Colors.black26),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
  }) : super(key: key);

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF5C35C7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight:
                    isSender ? Radius.circular(0) : Radius.circular(15),
                bottomLeft: isSender ? Radius.circular(15) : Radius.circular(0),
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              'jancok su',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFDBDBDB),
              ),
            ),
          ),
          Text(
            '10:33 PM',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF1F1F1F),
            ),
          )
        ],
      ),
    );
  }
}
