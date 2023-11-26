import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxBool isLoading = false.obs;

  static RxString inLang = 'cmn'.obs;
  static RxString outLang = 'eng'.obs;
  RxString wavPath = ''.obs;
  TextEditingController outText = TextEditingController();
  static RxString postType = 'file'.obs;

  static changeType(val) {
    HomeController.postType.value = val;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
