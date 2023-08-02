import 'dart:convert';

import 'package:comput/state/user_state.dart';
import 'package:comput/util/util.dart';
import 'package:http/http.dart' as http;

import 'list_data.dart';

class MessageApi {
  static Future<Map<String, dynamic>> getListDataDiff(
      {required List<ListData> listData}) async {
    final res = await http
        .post(Uri.parse('${Http.basicUrl}/getListData/diff'), headers: {
      "userid": User.userInfo?.id ?? ""
    }, body: {
      "content": jsonEncode(
          listData.map((data) => ListDataDiff.parseString(data)).toList())
    });
    try {
      var result = jsonDecode(res.body)['data'];
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ListData>> getListData({String? listDataId}) async {
    final res = await http.get(Uri.parse(
        '${Http.basicUrl}/getListData/${User.userInfo?.id}${listDataId != null ? '/$listDataId' : ''}'));
    try {
      var result = jsonDecode(res.body);
      return List.of(result['data'])
          .toList()
          .map((e) => ListData.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
