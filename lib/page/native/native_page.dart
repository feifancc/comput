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
        'avatar': 'https://avatars.githubusercontent.com/u/101034588?v=4',
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 241, 241, 241),
      child: SafeArea(
        child: PointMoveBack(
          pointCount: 6,
          child: ListView(
            children: listInfo
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
                                        child: Text('dsf') ??
                                            Image.network(e.userInfo.name)),
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
                .toList(),
          ),
        ),
      ),
    );
  }
}
