import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class ChangeProfileController extends GetxController {
  //TODO: Implement ChangeProfileController

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController statusController;

  @override
  void onInit() {
    emailController = TextEditingController(text: 'faizhid11@gmail.com');
    nameController = TextEditingController(text: 'Faiz Hidayatulloh');
    statusController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    statusController.dispose();
    super.onClose();
  }
}
