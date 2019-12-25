import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'common/common_util.dart';
import 'common/localization/lyyj_localizations_delegate.dart';
import 'common/navigator_utils.dart';
import 'common/redux/lyyj_state.dart';
import 'common/style/lyyj_style.dart';
import 'index.dart';
import 'routes/home.dart';

void main() {
  runZoned(() {
    WidgetsFlutterBinding.ensureInitialized();
    Global.init().then((e)=> runApp(MyApp()));
    Provider.debugCheckInvalidValueType = null;
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  /// 创建Store，引用 GSYState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = new Store<LYYJState>(
    appReducer,
    middleware: middleware,

    ///初始化数据
    initialState: new LYYJState(
        userInfo: User.empty(),
        themeData: CommonUtils.getThemeData(LYYJColors.primarySwatch),
        locale: Locale('zh', 'CH')),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: new StoreBuilder<LYYJState>(builder: (context, store) {
        return new MaterialApp(

            ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              LYYJLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            routes: {
              HomeRoute.sName: (context) {
                store.state.platformLocale =
                    WidgetsBinding.instance.window.locale;

                ///通过 Localizations.override 包裹一层，
                return new GSYLocalizations(
                    child: NavigatorUtils.pageContainer(HomeRoute()));
              },
            });
      }),
    );
  }
}

class GSYLocalizations extends StatefulWidget {
  final Widget child;

  GSYLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<GSYLocalizations> createState() {
    return new _GSYLocalizations();
  }
}

class _GSYLocalizations extends State<GSYLocalizations> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<LYYJState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }
}
