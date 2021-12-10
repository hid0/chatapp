import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  late TextEditingController searchController;

  @override
  void onInit() {
    // TODO: implement onInit
    searchController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    searchController.dispose();
    super.onClose();
  }
}
