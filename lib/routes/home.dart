import 'package:lyyj/common/style/lyyj_style.dart';
import 'package:lyyj/widgets/tabbar_widget.dart';

import '../index.dart';
import 'home_found.dart';
import 'home_my.dart';
import 'homt_index.dart';

class HomeRoute extends StatefulWidget {
  static final String sName = "/";

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int lastBackTime = 0;

  Future<bool> _doubleClickBack() {
    if (DateTime.now().millisecond - lastBackTime > 2000) {
      lastBackTime = DateTime.now().millisecond;
      Fluttertoast.showToast(msg: Global.getLocale(context).double_quit);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _renderTab(name, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            name,
            height: 20,
            width: 20,
          ),
          new Text(text)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab("images/main_bottom_index_normal.png",
          Global.getLocale(context).home_index),
      _renderTab("images/main_bottom_found_normal.png",
          Global.getLocale(context).home_found),
      _renderTab(
          "images/main_bottom_my_normal.png", Global.getLocale(context).home_my)
    ];

    return WillPopScope(
      onWillPop: _doubleClickBack,
      child: TabBarWidget(
        type: TabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: [HomeIndexPage(), HomeFoundPage(), HomeMyPage()],
        backgroundColor: LYYJColors.primarySwatch,
        indicatorColor: Color(LYYJColors.white),
        indicator: BoxDecoration(color: Colors.transparent),
      ),
    );
  }
}
