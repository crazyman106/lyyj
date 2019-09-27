import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'default_localizations.dart';

/**
 * 多语言代理
 * Created by guoshuyu
 * Date: 2018-08-15
 */
class LYYJLocalizationsDelegate extends LocalizationsDelegate<LYYJLocalizations> {

  LYYJLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<LYYJLocalizations> load(Locale locale) {
    return new SynchronousFuture<LYYJLocalizations>(new LYYJLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<LYYJLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static LYYJLocalizationsDelegate delegate = new LYYJLocalizationsDelegate();
}
