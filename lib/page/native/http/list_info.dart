import 'package:comput/page/native/http/oparator_info.dart';
import 'package:comput/page/native/http/user_info.dart';

class ListInfo {
  ListInfo({
    required this.title,
    required this.operator,
    required this.userInfo,
    required this.stare,
    this.imgs,
    this.commentCount,
    this.down,
    this.up,
    this.link,
  });

  final UserInfo userInfo;
  final String title;
  final OparatorInfo operator;
  List<String>? imgs;
  final int? stare;
  final int? commentCount;
  final int? up;
  final int? down;
  final String? link;

  factory ListInfo.formJson(Map<String, dynamic> map) => ListInfo(
        title: map['title'],
        operator: OparatorInfo.fromJson(map),
        userInfo: UserInfo.formJson(map['userInfo']),
        stare: map['stare'],
      );
}
