import 'dart:async';

import 'package:comput/page/message/http/index.dart';
import 'package:comput/page/message/http/user_info.dart';
import 'package:comput/state/user_state.dart';
import 'package:flutter/material.dart';

import 'package:comput/state/school_state.dart';
import 'http/list_data.dart';
import 'message_layout.dart';

class PubSub {
  static final Map<String, List<dynamic>> _map = {};

  static $remove<T>(String name, void Function(T a) callback) {
    if (_map[name] != null) {
      if (_map[name]!.contains(callback)) {
        _map[name]!.remove(callback);
        print(_map);
      }
    }
  }

  static $emit(String name, dynamic data) {
    if (_map[name] != null) {
      _map[name]?.forEach((callback) => callback(data));
    }
  }

  static $on<T>(String name, void Function(T a) callback) {
    if (_map[name] != null) {
      if (!_map[name]!.contains(callback)) {
        _map[name]!.add(callback);
      }
    } else {
      _map[name] = [callback];
    }
  }
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() => _MessagePage();
}

class _MessagePage extends State<MessagePage> {
  String active = '';

  List<ListData> listData = [];

  void changActive(String i) async {
    setState(() {
      if (listData.isNotEmpty) {
        active = i;
      }
    });
  }

  bool isLogin = User.userInfo != null;
  renderLogin() {
    setState(() {
      isLogin = User.userInfo != null;
    });
    renderListData();
  }

  renderPage() {
    switch (schoolState.direction) {
      case SchoolState.HORIZONTAL:
        return HorizontalMessageLayout(
          renderListData: renderListData,
          listData: listData,
          active: active,
          onChangeActive: changActive,
        );
      case SchoolState.VERTICAL:
        return VerticalMessageLayout(
          renderListData: renderListData,
          listData: listData,
          active: active,
          onChangeActive: changActive,
        );
      default:
        return const Text('null');
    }
  }

  renderListData({List<ListData>? resListData}) async {
    var value = resListData ?? await MessageApi.getListData();
    if (value.isNotEmpty && active.isNotEmpty) {
      PubSub.$emit('renderListData',
          value.firstWhere((element) => element.id == active));
    }
    setState(() {
      listData = value;
      String newActive = active;
      if (value.isNotEmpty) {
        if (newActive.isEmpty) {
          newActive = value.first.id;
        }
      }
      changActive(value.isNotEmpty ? newActive : active);
    });
  }

  Timer? timer;
  @override
  void initState() {
    renderListData();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      if (User.userInfo != null && listData.isNotEmpty) {
        final result = await MessageApi.getListDataDiff(listData: listData);
        if (result['isRender'] && result['data'] != null) {
          final List<Map<String, dynamic>> listDataMap =
              List.from(result['data']);
          renderListData(
            resListData: listDataMap.map((e) => ListData.fromJson(e)).toList(),
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLogin ? renderPage() : LoginPage(renderLogin: renderLogin),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.renderLogin});

  final Function() renderLogin;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Text msg = const Text('');
  setMsg(String m, {int? code}) {
    setState(() {
      msg = Text(
        m,
        style: TextStyle(
          color: code == 1000
              ? const Color.fromARGB(255, 14, 248, 34)
              : const Color.fromARGB(255, 248, 23, 23),
        ),
      );
    });
  }

  @override
  Widget build(context) {
    var fields = UserInfo.userInfoMap.map((e) => TextField(
          decoration: InputDecoration(label: Text(e['label'])),
          controller: e['contr'],
        ));
    return Column(
      children: [
        ...fields.toList(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              setMsg('加载冲');
              UserInfo.login().then((value) {
                setMsg(value['msg'], code: value['code']);
                Timer(const Duration(seconds: 1), () {
                  widget.renderLogin();
                });
              });
            },
            icon: const Icon(Icons.commit_sharp),
            label: const Text('提交'),
          ),
        ),
        msg
      ],
    );
  }
}
