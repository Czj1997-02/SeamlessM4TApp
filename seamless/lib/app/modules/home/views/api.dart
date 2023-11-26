import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
const BaseURL = 'http://127.0.0.1:8080';
class PostApi extends GetConnect {
  static sendPostRequest(inStr,postType,inLang,outLang) async {
    var request = http.MultipartRequest('POST', Uri.parse(BaseURL));
    if (postType == 'file') {
      // 添加文件到表单
      request.files.add(await http.MultipartFile.fromPath('file', inStr));
      request.fields['inType'] = 'speech';
    } else if (postType == 'text') {
      request.fields['inStr'] = inStr;
      request.fields['inType'] = 'text';
    }
    // 添加其他表单数据（如果需要）
    request.fields['key'] = 'ab7d978a80a0b833c460e4cf456edd6b';
    request.fields['postType'] = postType;
    request.fields['inLang'] = inLang;
    request.fields['outType'] = 'speech';
    request.fields['outLang'] = outLang;
    // 发送请求并获取响应
    var response = await request.send();
    String respStr = await response.stream.transform(utf8.decoder).join();
    var result = json.decode(respStr);
    if (response.statusCode == 200) {
      // 请求成功
      print('请求成功');
      return result;
    } else {
      // 请求失败
      print('请求失败');
      return result;
    }
  }
}