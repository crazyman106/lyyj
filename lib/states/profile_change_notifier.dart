import 'package:lyyj/common/redux/locale_redux.dart';
import 'package:lyyj/common/redux/lyyj_state.dart';
import 'package:redux/redux.dart';

import '../index.dart';

/**
 * 使用Provider包实现跨组件共享状态
 */
class ProfileChangeNotifier {
  Profile get _profile => Global.profile;
}

class UserModel {}

class LocaleModel {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  static changeLocale(Store<LYYJState> store, int index) {
    Locale locale = store.state.platformLocale;
    switch (index) {
      case 1:
        locale = Locale('zh', 'CH');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    store.dispatch(RefreshLocaleAction(locale));
  }
}
