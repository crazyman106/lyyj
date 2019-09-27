

import '../../index.dart';

/// 颜色
class LYYJColors{

  static const int primaryValue = 0xFFF54548;
  static const int primaryLightValue = 0xFFF94948;
  static const int primaryDarkValue = 0xDA4548;

  static const int white = 0xFFFFFFFF;
  static const int gray = 0xFF999999;










  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}
