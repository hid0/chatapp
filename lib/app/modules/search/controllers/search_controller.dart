import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchController extends GetxController {
  late TextEditingController searchController;

  var firstQuery = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchFriend(String data) async {
    // print('search : $data');
    if (data.length == 0) {
      firstQuery.value = [];
      tempSearch.value = [];
    } else {
      var upper = data.substring(0, 1).toUpperCase() + data.substring(1);
      // print(upper);
      if (firstQuery.length == 0 && data.length == 1) {
        CollectionReference client = await firestore.collection('users');
        final keyRes = await client
            .where('keyName', isEqualTo: data.substring(0, 1).toUpperCase())
            .get();
        print('total ${keyRes.docs.length}');
        if (keyRes.docs.length > 0) {
          for (int i = 0; i < keyRes.docs.length; i++) {
            firstQuery.add(keyRes.docs[i].data() as Map<String, dynamic>);
          }
          print('query = ');
          print(firstQuery);
        } else {
          print('data not found');
        }
      }

      if (firstQuery.length != 0) {
        tempSearch.value = [];
        firstQuery.forEach((element) {
          if (element['name'].startsWith(upper)) {
            tempSearch.add(element);
          }
        });
      }
    }
    firstQuery.refresh();
    tempSearch.refresh();
  }

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
