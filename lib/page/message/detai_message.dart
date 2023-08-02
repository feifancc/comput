import 'package:comput/page/message/message_page.dart';
import 'package:comput/state/user_state.dart';
import 'package:comput/widgets/operate/operate_com.dart';
import 'package:comput/widgets/operate/pressed_operate.dart';
import 'package:comput/widgets/operate/pressed_operate_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'http/list_data.dart';
import 'http/list_message.dart';

class DetailMessage extends StatefulWidget {
  const DetailMessage({
    super.key,
    required this.listData,
    required this.renderListData,
  });

  final void Function() renderListData;
  final ListData? listData;
  @override
  State<StatefulWidget> createState() => _DetailMessage();
}

class _DetailMessage extends State<DetailMessage> {
  ListData? orginListData;

  ListData? get listData {
    ListData? data = orginListData ?? widget.listData;
    return data;
  }

  ListData? oldParentListData;
  isReload(ListData? data) {
    if (oldParentListData != null && data != null) {
      if (oldParentListData!.id != data.id) {
        widget.renderListData();
      }
    }
    oldParentListData = data;
  }

  // 顶部标题
  get detailMesssageTitle {
    String? name = "";

    String? myId = User.userInfo?.id;

    Map<String, dynamic> one = {
      "id": listData?.userOneId,
      "name": listData?.userOneName
    };
    Map<String, dynamic> two = {
      "id": listData?.userTwoId,
      "name": listData?.userTwoName
    };

    if (myId != null) {
      name = one['id'] == myId ? two['name'] : one['name'];
    }
    return '与 $name 的对话';
  }

  // 添加消息
  clickAddMessage(TextEditingController contr) async {
    final code = await Message.addMessage(
      userId: User.userInfo!.id,
      listDataId: listData?.id ?? "",
      type: Message.MESSAGE,
      content: contr.text,
    );

    if (code == 1000) {
      widget.renderListData();
      contr.clear();
    }
  }

  onRenderListData(ListData value) {
    bool isRender = false;
    if (value.listMessage.isNotEmpty &&
        orginListData != null &&
        orginListData!.listMessage.isNotEmpty) {
      int i = 0;
      for (var element in value.listMessage) {
        var oldValue = orginListData?.listMessage[i];
        if (oldValue?.id != element.id ||
            oldValue?.type != element.type ||
            oldValue?.content != element.content) {
          isRender = true;
        }
      }
    } else {
      isRender = true;
    }
    if (isRender) {
      setState(() {
        orginListData = value;
      });
    }
  }

  // INFO: 长按操作按钮设置
  List<PressedOperateState> pressStates = [
    PressedOperateState(label: '赞'),
    PressedOperateState(label: '复制'),
    PressedOperateState(label: '撤回'),
    PressedOperateState(label: '搜索'),
    PressedOperateState(label: '取消'),
  ];
  // 操作菜单顶部位置
  double? top;
  // 操作菜单key
  final GlobalKey _floatOperateKey = GlobalKey();
  Message? currentMsg;
  // 操作菜单选项
  late List<PressedOperate> longPressedOperates;
  // 操作菜单选项点击回调
  void methodPressed({required PressedOperateState state, Message? msg}) {
    switch (state.label) {
      case '赞':
        break;
      case '复制':
        Clipboard.setData(ClipboardData(text: currentMsg?.content ?? ''));
        break;
      case '撤回':
        if (msg != null) {
          handleRevokeMessage(messageId: msg.id);
        }
        break;
      case '搜索':
        break;
      case '取消':
        break;
      default:
    }
    setState(() {
      top = null;
      currentMsg = null;
    });
  }

  // 消息列表的scorll值
  double msgScroll = 0;
  // 触发操作菜单弹出回调
  void computeOperationPosition(
      {required GlobalKey currentKey, required Message msg}) {
    RenderBox? currentObj =
        currentKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? floatOperateObj =
        _floatOperateKey.currentContext?.findRenderObject() as RenderBox?;
    if (currentObj == null || floatOperateObj == null) return;
    Offset currentOffset = currentObj.localToGlobal(Offset.zero);
    setState(() {
      top = currentOffset.dy - 60;
      currentMsg = msg;
    });
  }

  @override
  void initState() {
    PubSub.$on<ListData>('renderListData', onRenderListData);

    longPressedOperates = pressStates
        .map((str) => PressedOperate(
              str,
              onPressed: (state) {
                if (str.methodPressed != null) {
                  str.methodPressed!(state);
                } else {
                  methodPressed(state: state, msg: currentMsg);
                }
              },
            ))
        .toList();
    // 消息滚动事件,消息滚动时操作菜单跟着变化高度
    scrollContr.addListener(() {
      double diff = scrollContr.offset - msgScroll;
      if (top != null) {
        setState(() {
          top = top! - diff;
        });
      }
      setState(() {
        msgScroll = scrollContr.offset;
      });
    });
    super.initState();
  }

  @override
  void deactivate() {
    PubSub.$remove<ListData>('renderListData', onRenderListData);
    super.deactivate();
  }

  TextEditingController contr = TextEditingController();

  ScrollController scrollContr = ScrollController(keepScrollOffset: false);

  @override
  Widget build(BuildContext context) {
    isReload(widget.listData);
    print('render');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          detailMesssageTitle,
        ),
      ),
      bottomNavigationBar: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: TextField(
            maxLines: 2,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              suffix: ElevatedButton(
                  onPressed: () => clickAddMessage(contr),
                  child: const Text('提交')),
              label: const Text(''),
            ),
            controller: contr,
          ),
        ),
      ),
      body: AnimatedPadding(
        duration: const Duration(milliseconds: 2000),
        padding: const EdgeInsets.all(0),
        curve: Curves.fastOutSlowIn,
        child: Stack(
          children: [
            ListView(
              controller: scrollContr,
              children: [
                ...listData?.listMessage.map((e) {
                      GlobalKey key = GlobalKey();
                      Widget com;
                      bool isOneself = e.userId == User.userInfo?.id;
                      switch (e.type) {
                        case Message.MESSAGE:
                          com = Column(
                            key: key,
                            crossAxisAlignment: isOneself
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.userName,
                                textAlign: isOneself
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                              InkWell(
                                highlightColor: Color(0x000000),
                                splashColor: Color(0x000000),
                                hoverColor: Color(0x000000),
                                onLongPress: () {
                                  isOneself
                                      ? computeOperationPosition(
                                          currentKey: key, msg: e)
                                      : null;
                                },
                                onSecondaryTapUp: (p) => isOneself
                                    ? computeOperationPosition(
                                        currentKey: key, msg: e)
                                    : null,
                                child: Card(
                                  color: isOneself
                                      ? Theme.of(context).splashColor
                                      : Theme.of(context).canvasColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.content,
                                      style: TextStyle(
                                        color: isOneself
                                            ? Theme.of(context).cardColor
                                            : const Color.fromARGB(
                                                255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        case Message.REVOKE:
                          com = Center(
                            child: Card(
                              color: Theme.of(context).disabledColor,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                child: Text(
                                  "${isOneself ? '你' : e.userName}撤回了一条消息",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          );
                        default:
                          com = const Text('df');
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: com,
                      );
                    }).toList() ??
                    [],
              ],
            ),
            FloatOperate(
              top: top,
              key: _floatOperateKey,
              longPressedOperates: longPressedOperates,
            ),
          ],
        ),
      ),
    );
  }

  handleRevokeMessage({required String messageId}) async {
    await Message.revokeMessage(
      listDataId: listData!.id,
      messageId: messageId,
    );
    widget.renderListData();
  }
}
