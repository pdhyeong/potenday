import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../env/env.dart';
import 'package:provider/provider.dart';

const String apiKey = Env.apiKey;
const String apiKeyPrimaryVal = Env.apiKeyPrimaryVal;
const host = 'https://clovastudio.stream.ntruss.com';

class Server {
  Map<String, dynamic> view = {};
  Map<String, dynamic> returnJson(dynamic data) {
    String save = jsonEncode(data);
    Map<String, dynamic> returnJson = jsonDecode(save);
    return returnJson;
  }

  Future<String> execute(List<String> arr) async {
    final dio = Dio();
    final headers = {
      'X-NCP-CLOVASTUDIO-API-KEY': apiKey,
      'X-NCP-APIGW-API-KEY': apiKeyPrimaryVal,
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': '*/*',
    };
    List<Object> presetText = [
      {
        "role": "user",
        "content":
            "나의 성격 : ${arr[0]}, 남에게 보이고 싶은 성격: ${arr[1]}, 메시지 받는 사람 : ${arr[3]}, 목적: ${arr[4]}, 상세목적: ${arr[5]}, 덧붙일 말: ${arr[5]} 인데 메시지를 작성해줘."
      },
    ];

    Map<String, dynamic> requestData = {
      'messages': presetText,
      'topP': 0.8,
      'topK': 0,
      'maxTokens': 256,
      'temperature': 0.5,
      'repeatPenalty': 5.0,
      'stopBefore': [],
      'includeAiFilters': true
    };

    try {
      final response = await dio.post(
        '$host/testapp/v1/chat-completions/HCX-002',
        options: Options(headers: headers),
        data: requestData,
      );
      dynamic data = response.data;
      view = returnJson(data);
    } catch (error) {
      print('Dio Exception (POST): $error');
    }
    return view['result']['message']['content'];
  }
}

Server server = Server();
