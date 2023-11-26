import 'package:get/get.dart';

import '../controllers/setups_controller.dart';

class SetupsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupsController>(
      () => SetupsController(),
    );
  }
}
