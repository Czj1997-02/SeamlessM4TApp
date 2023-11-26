import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../home/views/ChoicesOne.dart';
import '../controllers/setups_controller.dart';

class SetupsView extends GetView<SetupsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setups'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            child: Obx(()=>ChoicesOne(
              onValues: HomeController.inLang.value,
              title: '输入语种',
              choices: controller.speechSource,
              onChoices: (value) { HomeController.inLang.value = value.toString(); },
            )),
            padding: const EdgeInsets.all(10.0),
          ),
          Container(
            child: Obx(()=>ChoicesOne(
              onValues: HomeController.outLang.value,
              title: '输出语种',
              choices: controller.speechTarget,
              onChoices: (value) { HomeController.outLang.value = value.toString(); },
            )),
            padding: const EdgeInsets.all(10.0),
          ),
        ],
      ),
    );
  }
}
