import 'package:comput/state/user_state.dart';
import 'package:flutter/material.dart';

import 'detai_message.dart';
import 'http/list_data.dart';

class ListActive extends ChangeNotifier {}

class MessageLayout extends StatelessWidget {
  MessageLayout({
    super.key,
    required this.listData,
    required this.active,
    required this.onChangeActive,
    required this.renderListData,
  });
  final void Function() renderListData;
  final String active;
  final List<ListData> listData;
  final void Function(String f) onChangeActive;
  

  String getMessageListConten(ListData data) {
    if (User.userInfo?.id != null && data.listMessage.isNotEmpty) {
      String content = data.listMessage.last.type == 1
          ? "撤回了一条消息"
          : ':${data.listMessage.last.content}';
      return '${User.userInfo?.id == data.listMessage.last.userId ? '你' : data.listMessage.last.userName}$content';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return const Text('data');
  }

  final Map<String, dynamic> _tipsInfo = {};
  setTipsInfo({required String id, required int changed}) {
    switch (changed) {
      case 0:
        changed = _tipsInfo[id] ?? changed;
        break;
      case -1:
        changed = 0;
        break;
    }
    _tipsInfo[id] = (_tipsInfo[id] ?? 0) + changed;
  }

  /// INFO: 新消息数量提示
  Widget _tips(ListData e, bool vertical) {
    setTipsInfo(id: e.id, changed: active == e.id ? -1 : e.changed ?? 0);
    return e.changed != null &&
            (!vertical && active != e.id) &&
            _tipsInfo[e.id] != 0
        ? Card(
            color: Color(0xffff0000),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
              child: Text(
                '${_tipsInfo[e.id]}',
                style: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          )
        : const Text('');
  }

  /// INFO: 渲染消息列表
  Widget renderRowMessage(ListData e, bool vertical) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              User.userInfo?.id != e.userOneId ? e.userOneName : e.userTwoName,
              style: const TextStyle(fontSize: 18),
            ),
            _tips(e, vertical),
          ],
        ),
        Text(
          getMessageListConten(e),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// 横向展示布局
class HorizontalMessageLayout extends MessageLayout {
  HorizontalMessageLayout({
    super.key,
    required super.listData,
    required super.active,
    required super.onChangeActive,
    required super.renderListData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: Column(
            children: [
              ...listData.map((e) {
                return InkWell(
                  highlightColor: Theme.of(context).primaryColor,
                  splashColor: Theme.of(context).primaryColor,
                  canRequestFocus: false,
                  onTap: () => onChangeActive(e.id),
                  child: Container(
                    width: 120,
                    color:
                        active == e.id ? Theme.of(context).primaryColor : null,
                    padding: const EdgeInsets.all(8),
                    child: renderRowMessage(e, false),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        Expanded(
          flex: 82,
          child: DetailMessage(
            listData: currentListData,
            renderListData: super.renderListData,
          ),
        )
      ],
    );
  }

  get currentListData {
    if (listData.isNotEmpty) {
      return listData.firstWhere((e) => e.id == active);
    }
    return null;
  }
}

/// 纵向布局
class VerticalMessageLayout extends MessageLayout {
  VerticalMessageLayout({
    super.key,
    required super.listData,
    required super.active,
    required super.onChangeActive,
    required super.renderListData,
  });

  @override
  Widget build(context) {
    return Scrollbar(
      child: ListView(
        children: listData.map((e) {
          return InkWell(
            onTap: () {
              onChangeActive(e.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMessage(
                    renderListData: super.renderListData,
                    listData: e,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: renderRowMessage(e, true),
            ),
          );
        }).toList(),
      ),
    );
  }
}
