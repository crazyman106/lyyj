import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lyyj/common/style/lyyj_string_base.dart';
import 'package:lyyj/common/style/lyyj_string_en.dart';
import 'package:lyyj/common/style/lyyj_string_zh.dart';

///自定义多语言实现
class LYYJLocalizations {
  final Locale locale;

  LYYJLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了GSYStringBase
  static Map<String, LYYJStringBase> _localizedValues = {
    'en': new LYYJStringEn(),
    'zh': new LYYJStringZh(),
  };

  LYYJStringBase get currentLocalized {
    if(_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues["en"];
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static LYYJLocalizations of(BuildContext context) {
    return Localizations.of(context, LYYJLocalizations);
  }
}
