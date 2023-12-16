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
  List<Map<String, dynamic>> view = [];
  Future<void> execute(List<String> arr) async {
    final dio = Dio();
    final headers = {
      'X-NCP-CLOVASTUDIO-API-KEY': apiKey,
      'X-NCP-APIGW-API-KEY': apiKeyPrimaryVal,
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': '*/*',
    };

    List<Object> presetText = [
      {"role": "user", "content": "반가워"},
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
      String save = jsonEncode(data);
      String newData = save.replaceAll('\\', '');
      Map<String, dynamic> result = jsonDecode(newData);
      print(result['result']['message']['content']);
    } catch (error) {
      print('Dio Exception (POST): $error');
    }
  }
}

Server server = Server();
