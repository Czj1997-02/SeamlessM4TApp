/// Author: Samle
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 页面参数使用状态管理进行缓存
class SysStore {

  // 根路由
  setBaseUrl(String baseUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('base_url', baseUrl);
  }
  getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('base_url') ?? '';
    return baseUrl;
  }

  // 发送形式
  setPostType(String postType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('post_type', postType);
  }
  getPostType() async {
    final prefs = await SharedPreferences.getInstance();
    final postType = prefs.getString('post_type') ?? 'file';
    return postType;
  }

  // 传入语种
  setInLang(String inLang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('in_lang', inLang);
  }
  getInLang() async {
    final prefs = await SharedPreferences.getInstance();
    final inLang = prefs.getString('in_lang') ?? 'cmn';
    return inLang;
  }

  // 传出语种
  setOutLang(String outLang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('out_lang', outLang);
  }
  getOutLang() async {
    final prefs = await SharedPreferences.getInstance();
    final outLang = prefs.getString('out_lang') ?? 'eng';
    return outLang;
  }

}