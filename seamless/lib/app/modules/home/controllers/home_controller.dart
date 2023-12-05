import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seamless/store/sys_store.dart';

class HomeController extends GetxController {
  SysStore sysStore = SysStore();

  RxBool isLoading = false.obs;

  static RxString inLang = 'cmn'.obs;
  static RxString outLang = 'eng'.obs;
  RxString wavPath = ''.obs;
  TextEditingController outText = TextEditingController();
  TextEditingController inText = TextEditingController();
  static RxString postType = 'file'.obs;

  static changeType(val) {
    SysStore sysStore = SysStore();
    HomeController.postType.value = val;
    sysStore.setPostType(val);
  }

  getStore() async {
     inLang.value =  await sysStore.getInLang();
     outLang.value =  await sysStore.getOutLang();
     postType.value =  await sysStore.getPostType();
  }


  @override
  Future<void> onInit() async {
    await getStore();
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
