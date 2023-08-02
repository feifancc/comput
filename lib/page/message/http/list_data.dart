import 'package:comput/page/message/http/list_message.dart';

class ListData {
  final String id;
  final String userOneId;
  final String userOneName;
  final String userTwoId;
  final String userTwoName;
  final List<Message> listMessage;
  final int? changed;

  const ListData({
    required this.id,
    required this.userOneId,
    required this.userOneName,
    required this.userTwoId,
    required this.userTwoName,
    required this.listMessage,
    this.changed,
  });

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        id: json['_id'],
        userOneId: json['userOneId'],
        userOneName: json['userOneName'],
        userTwoId: json['userTwoId'],
        changed: json['changed'],
        userTwoName: json['userTwoName'],
        listMessage: List.of(json['listMessage'])
            .map((e) => Message.fromJson(e))
            .toList(),
      );
}

class ListDataDiff {
  final String id;
  final List<MessageDiff> listMessageDiff;

  ListDataDiff({required this.id, required this.listMessageDiff});

  factory ListDataDiff.fromJson(Map<String, dynamic> json) =>
      ListDataDiff(id: json['_id'], listMessageDiff: json['listMessage']);

  static parseString(ListData dataDiff) {
    return {
      "id": dataDiff.id,
      "listMessageDiff":
          dataDiff.listMessage.map((e) => MessageDiff.parseString(e)).toList()
    };
  }
}
