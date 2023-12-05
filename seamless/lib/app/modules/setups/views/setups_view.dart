import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../store/sys_store.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/ChoicesOne.dart';
import '../controllers/setups_controller.dart';

class SetupsView extends GetView<SetupsController> {

  SysStore sysStore = SysStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setups'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      border: Border.all(
                          color: Colors.black38, width: 1),
                      borderRadius: BorderRadius.circular((10.0))),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    maxLines: null,
                    controller: controller.baseUrl, // 绑定控制器到文本框
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '后端地址：http://127.0.0.1:8080',
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.baseUrl.clear();
                            controller.baseUrl.text = '';
                            sysStore.setBaseUrl('');
                          },//
                          icon: const Icon(Icons.cancel,size: 18,)
                      ),
                      contentPadding: const EdgeInsets.all(8.5),
                      border: InputBorder.none,
                    ),
                    autofocus: false,
                    onChanged: (val) {
                      sysStore.setBaseUrl(val);
                    },
                  )
              )
          ),
          Obx(()=>
            HomeController.postType.value == 'file' ? Container(
              child: Obx(()=>ChoicesOne(

                onValues: HomeController.inLang.value,
                title: '输入语种',
                choices: controller.speechSource,
                onChoices: (value) {
                  HomeController.inLang.value = value.toString();
                  sysStore.setInLang(value.toString());
                  },
              )),
              padding: const EdgeInsets.all(10.0),
            ): Container(
              child: Obx(()=>ChoicesOne(
                onValues: HomeController.inLang.value,
                title: '输入语种',
                choices: controller.textSource,
                onChoices: (value) {
                  HomeController.inLang.value = value.toString();
                  sysStore.setInLang(value.toString());
                  },
              )),
              padding: const EdgeInsets.all(10.0),
          )),
          Container(
            child: Obx(()=>ChoicesOne(
              onValues: HomeController.outLang.value,
              title: '输出语种',
              choices: controller.speechTarget,
              onChoices: (value) {
                HomeController.outLang.value = value.toString();
                sysStore.setOutLang(value.toString());
                },
            )),
            padding: const EdgeInsets.all(10.0),
          ),
        ],
      ),
    );
  }
}
