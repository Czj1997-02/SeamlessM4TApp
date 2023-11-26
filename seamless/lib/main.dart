import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    // 设置Appbar上面的电池显示的状态栏的背景与颜色
    SystemUiOverlayStyle systemUiOverlayStyle =
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIOverlays([]); //隐藏状态栏
  }
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SeamlessM4T",//
      theme: ThemeData(platform: TargetPlatform.iOS,),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      //国际化
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
    ),
  );
}