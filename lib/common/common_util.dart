import 'dart:ui';

import '../index.dart';

class CommonUtils {
  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }
}
