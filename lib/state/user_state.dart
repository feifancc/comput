import 'package:flutter/cupertino.dart';

import '../page/message/http/user_info.dart';

class User extends ChangeNotifier {
  static UserInfo? userInfo;

  Function(UserInfo user)? setUserInfo(UserInfo user) {
    userInfo = user;
    notifyListeners();
    return null;
  }
}
