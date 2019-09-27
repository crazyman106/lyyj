import 'dart:convert';

import 'package:lyyj/common/http/http.dart';
import 'package:lyyj/common/redux/lyyj_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../index.dart';
import 'http/http_interceptor.dart';
import 'localization/default_localizations.dart';
import 'redux/locale_redux.dart';
import 'style/lyyj_string_base.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

/**
 *  全局变量-Global类
 */
class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  static LYYJStringBase getLocale(BuildContext context) {
    return LYYJLocalizations.of(context).currentLocalized;
  }

  // 网络缓存对象
  static HttpInterceptors cache = new HttpInterceptors();

  // 主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 600
      ..maxCount = 100;

    // 初始化网络请求相关配置
    (httpClient as HttpClient).init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));

  static save(String key, value) async {
    _prefs.setString(key, value);
  }

  static get(String key) async => _prefs.get(key);

  static remove(String key) async {
    _prefs.remove(key);
  }
}
