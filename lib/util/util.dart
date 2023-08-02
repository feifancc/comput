class Util {
  static double toDouble(dynamic target) {
    double d = 0.0;
    try {
      d = double.parse(target);
    } catch (e) {
      e;
    }
    return d;
  }

  static String insertTextLeft(String str, {required String leftText}) {
    return '$leftText:$str';
  }

  static String insertTextRight(String str, {required String rightText}) {
    return '$str:$rightText';
  }
}

class Http {
  static String basicUrl = 'http://43.139.55.105/api';
}
