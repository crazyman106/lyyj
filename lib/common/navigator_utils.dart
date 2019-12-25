import 'package:flutter/cupertino.dart';
import 'package:lyyj/routes/login.dart';
import 'package:lyyj/routes/order_list.dart';
import 'package:lyyj/routes/person_info.dart';
import 'package:lyyj/routes/setting.dart';

import '../index.dart';

class NavigatorUtils {
  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context,
        new CupertinoPageRoute(builder: (context) => pageContainer(widget)));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget) {
    return MediaQuery(
        ///不受系统字体缩放影响
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(textScaleFactor: 1),
        child: widget);
  }

  ///个人中心
  static goPersonRoute(BuildContext context) {
    NavigatorRouter(context, PersonInfoRoute());
  }

  ///设置
  static goSettingRoute(BuildContext context) {
    NavigatorRouter(context, SettingRoute());
  }

  ///订单列表
  static goOrderListRoute(BuildContext context) {
    NavigatorRouter(context, OrderListRoute());
  }

  // 跳转登录页面
  static goLoginRoute(BuildContext context) {
    NavigatorRouter(context, LoginRoute());
  }
}
