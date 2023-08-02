import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../state/user_state.dart';
import '../../../util/util.dart';

class UserInfo {
  final String id;
  final String name;
  final int code;

  static List<Map<String, dynamic>> userInfoMap = [
    {
      "label": "用戶名",
      "name": "name",
      "contr": TextEditingController(text: 'feifan')
    },
    {
      "label": "代碼",
      "name": "code",
      "contr": TextEditingController(text: "123456")
    },
  ];

  static Future<Map<String, dynamic>> login() async {
    final res = await http.post(Uri.parse('${Http.basicUrl}/login'), body: {
      "name": userInfoMap[0]['contr'].text,
      "code": userInfoMap[1]['contr'].text
    });
    try {
      Map<String, dynamic> result = jsonDecode(res.body);
      if (result['code'] == 1000) {
        User.userInfo = UserInfo.fromJson(result['data']);
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  UserInfo({required this.id, required this.code, required this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        code: json['code'],
        name: json['name'],
        id: json['_id'],
      );
}
