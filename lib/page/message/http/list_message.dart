// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:comput/util/util.dart';

class Message {
  final String id;
  final String userId;
  final String userName;
  final int type;
  final String content;
  const Message({
    required this.id,
    required this.userId,
    required this.userName,
    required this.type,
    required this.content,
  });

  /// 添加记录
  static Future<dynamic> addMessage(
      {required String userId,
      required String listDataId,
      required int type,
      required String content}) async {
    try {
      final res = await http.post(Uri.parse('${Http.basicUrl}/addMessage'),
          body: {
            "userId": userId,
            "listDataId": listDataId,
            "type": "$type",
            "content": content
          });
      final code = jsonDecode(res.body)['code'];
      return code;
    } catch (e) {
      rethrow;
    }
  }

  /// 撤回记录
  static Future<bool> revokeMessage(
      {required String listDataId, required String messageId}) async {
    try {
      final result = await http.get(Uri.parse(
          '${Http.basicUrl}/message/revoke/$messageId/$listDataId?type=$REVOKE'));
      int code = jsonDecode(result.body)['code'];
      return code == 1000;
    } catch (e) {
      rethrow;
    }
  }

  static const int MESSAGE = 0;
  static const int REVOKE = 1;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json['content'],
        userId: json['userId'],
        userName: json['userName'],
        type: json['type'] ?? MESSAGE,
        id: json['_id'],
      );
}

class MessageDiff {
  final String id;
  final int type;
  final String content;
  factory MessageDiff.fromJson(Map<String, dynamic> json) => MessageDiff(
      type: json['type'] ?? Message.MESSAGE,
      id: json['_id'],
      content: json['content']);

  MessageDiff({required this.content, required this.id, required this.type});

  static parseString(Message message) {
    return {"id": message.id, "type": message.type, "content": message.content};
  }
}
