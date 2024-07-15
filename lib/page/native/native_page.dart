import 'package:comput/widgets/PointMoveBack/index.dart';
import 'package:comput/page/native/http/list_info.dart';
import 'package:comput/page/native/http/oparator_info.dart';
import 'package:comput/page/native/http/user_info.dart';
import 'package:flutter/material.dart';

class Native extends StatefulWidget {
  const Native({super.key});

  @override
  State<Native> createState() => _Native();
}

class _Native extends State<Native> {
  final List<ListInfo> listInfo = [
    ListInfo(
      title:
          '撒发撒防守打法啥地方撒地方三撒发撒防守打sdafdsfffdfsasd法啥地方撒地方三撒发撒防守打法啥地方撒地方三撒发撒防守打法啥地方撒地方三撒发撒防守打法啥地方撒地方三撒发撒防守打法啥地方撒地方三撒发撒防守打sdafdsfffdfsasd法啥地方撒地方三撒发撒防守打法啥地方撒地方三撒发撒防守打法啥地方撒地方三撒发撒防守打法啥地方撒地方三',
      userInfo: UserInfo.formJson({
        'avatar':
            'https://copilot.microsoft.com/rp/R8ErSC7kK_3o4eRM-pP2JlReVkE.png',
        "id": '1',
        'href':
            'https://github.com/_side-panels/user?memex_enabled=true&user=feifancc&user_can_create_organizations=true&user_id=101034588',
        'name': 'feifan'
      }),
      operator: OparatorInfo(icon: Icons.abc_sharp, label: 'abc'),
      stare: 50,
    ),
    ListInfo(
      title: '撒发撒防守打法啥地方撒地方三',
      userInfo: UserInfo.formJson({
        'avatar': 'https://avatars.githubusercontent.com/u/101034588?v=4',
        "id": '2',
        'href':
            'https://github.com/_side-panels/user?memex_enabled=true&user=feifancc&user_can_create_organizations=true&user_id=101034588',
        'name': 'feifan',
      }),
      operator: OparatorInfo(icon: Icons.abc_sharp, label: 'abc'),
      stare: 50,
    ),
    ListInfo(
      title: '撒发撒防守打法啥地方撒地方三',
      userInfo: UserInfo.formJson({
        'avatar': 'https://avatars.githubusercontent.com/u/101034588?v=4',
        "id": '3',
        'href':
            'https://github.com/_side-panels/user?memex_enabled=true&user=feifancc&user_can_create_organizations=true&user_id=101034588',
        'name': 'feifan',
      }),
      operator: OparatorInfo(icon: Icons.abc_sharp, label: 'abc'),
      stare: 50,
    ),
  ];

  bool _isShow = false;
  setIsShow() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    var messageList = listInfo
        .map(
          (e) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Container(
              color: const Color(0xaaffffff),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTapUp: (detail) {},
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipOval(
                                child: Image.network(e.userInfo.avatar)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e.userInfo.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    Text(
                      e.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
    return Container(
      color: const Color.fromARGB(255, 241, 241, 241),
      child: SafeArea(
        left: true,
        right: true,
        child: PointMoveBack(
          pointCount: 10,
          child: ListView(
            children: [
              ...(_isShow ? messageList : []),
              TextButton(
                onPressed: setIsShow,
                child: Text(_isShow ? '展示' : '收起'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
