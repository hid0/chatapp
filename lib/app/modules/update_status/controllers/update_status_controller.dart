import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStatusController extends GetxController {
  late TextEditingController statusController;

  @override
  void onInit() {
    // TODO: implement onInit
    statusController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    statusController.dispose();
    super.onClose();
  }
}
