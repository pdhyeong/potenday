import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:potenday/screen/splash_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

class GlobalStore extends ChangeNotifier {
  List<String> arr = ["", "", "", "", "", "", "", "", "", ""];
}

void main() {
  KakaoSdk.init(nativeAppKey: "1e56bed897ba5ca2e3688cb8122450c4");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalStore()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
