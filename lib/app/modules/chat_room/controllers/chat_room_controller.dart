import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  //TODO: Implement ChatRoomController

  var isShowEmoji = false.obs;

  late FocusNode focusNode;
  late TextEditingController chatController;

  void addEmoToInput(emoji) {
    chatController.text = chatController.text + emoji.emoji;
  }

  void delEmo() {
    chatController.text =
        chatController.text.substring(0, chatController.text.length - 2);
  }

  @override
  void onInit() {
    chatController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    chatController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
