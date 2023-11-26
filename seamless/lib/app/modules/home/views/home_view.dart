import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:xbr_plugin_record/widgets/voice_widget.dart';
import '../controllers/home_controller.dart';
import 'InputTab.dart';
import 'api.dart';

class HomeView extends GetView<HomeController> {

  AudioPlayer audioPlugin = AudioPlayer();

  startRecord() {
    print("开始录制");
    controller.outText.text = '';
  }
  stopRecord(String path, double audioTimeLength, bool isUp) async {
    print("结束束录制");
    print("音频文件位置" + path);
    print("音频录制时长" + audioTimeLength.toString());
    print("是否上滑取消" + isUp.toString());
    if (!isUp) {
      controller.isLoading.value = true;
      var res = await PostApi.sendPostRequest(path,'file',HomeController.inLang.value,HomeController.outLang.value);
      controller.isLoading.value = false;
      print(res);
      if (res['code'] == 200) {
        controller.outText.text = res['data']['text'];
        controller.wavPath.value = res['data']['wav'];
        await audioPlugin.play(res['data']['wav']);
      }
    }
    // var sendRes = await FilesApi.uploadFilePath(path);
  }
  sendText(String inStr) async {
    controller.isLoading.value = true;
    var res = await PostApi.sendPostRequest(inStr,'text',HomeController.inLang.value,HomeController.outLang.value);
    controller.isLoading.value = false;
    print(res);
    if (res['code'] == 200) {
      controller.outText.text = res['data']['text'];
      controller.wavPath.value = res['data']['wav'];
      await audioPlugin.play(res['data']['wav']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeamlessM4T'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: (){
            Get.toNamed('/setups');
          },
        ),
        actions: [
          Obx(()=>
            HomeController.postType.value == 'file' ? IconButton(
              icon: const Icon(Icons.text_fields),
              onPressed: (){
                HomeController.changeType("text");
              },
            ): IconButton(
              icon: const Icon(Icons.keyboard_voice_outlined),
              onPressed: (){
                HomeController.changeType("file");
              },
            )
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child:Obx(()=>ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox( //约束盒子
              constraints: const BoxConstraints.expand(),//不指定高和宽时则铺满整个屏慕
              child: Stack(
                alignment:Alignment.center , //指定对齐方式为居中
                children: <Widget>[ //子组件列表
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              border: Border.all(
                                  color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.circular((10.0))),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            maxLines: null,
                            controller: controller.outText, // 绑定控制器到文本框
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: '输出文本',
                              suffixIcon: IconButton(
                                  onPressed: () {controller.outText.clear();},//
                                  icon: Icon(Icons.cancel,size: 18,)
                              ),
                              contentPadding: const EdgeInsets.all(8.5),
                              border: InputBorder.none,
                            ),
                            autofocus: false,
                          )
                        )

                      ),
                      Container(
                        child: Obx(()=>controller.wavPath.value != ''?
                            ElevatedButton(
                              onPressed: () async {
                                await audioPlugin.play(controller.wavPath.value);
                              },
                              child: const Text('播放'),
                            ):const SizedBox()
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),

                    ],
                  ),
                  Positioned(
                    bottom: 0.0,//距离顶部18px（在中轴线上,因为Stack摆放在正中间）
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child:
                    Obx(()=>HomeController.postType.value == 'file' ? Container(
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 5.0),
                        // color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: VoiceWidget(
                        margin: const EdgeInsets.only(bottom: 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 0),
                        ),
                        height: 120.0,
                        startRecord: startRecord,
                        stopRecord: stopRecord,
                      ),
                    ): InputTab(
                      onChange: (String value) {  },
                      onCheck: (String value) {
                        controller.outText.text = '';
                        controller.wavPath.value = '';
                        if (value != '') {
                          sendText(value);
                        }
                      },
                    )),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
