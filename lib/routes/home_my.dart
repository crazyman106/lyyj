import 'package:flutter/services.dart';
import 'package:lyyj/common/navigator_utils.dart';
import 'package:lyyj/models/template.dart';
import 'package:lyyj/widgets/home_my_item.dart';

import '../index.dart';

class HomeMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeMyState();
  }
}

class HomeMyState extends State<HomeMyPage> {
  ScrollController _scrollController = ScrollController(); // 滑动控制器
  List<TemplateBean> list = new List(); //要展示的列表数据

  @override
  void initState() {
    super.initState();
    _onRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onGetList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _statusbarHeight = MediaQuery.of(context).padding.top; // 状态栏高度
    // kToolbarHeight;AppBar高度
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 230),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemBuilder: _renderRow,
                  itemCount: /*list.length*/5,
                  controller: _scrollController,
                ),
              ),
            ),
            Container(
              height: 246,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "images/my_top_bg.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 179, left: 8, right: 8),
                    height: 67,
                    child: Card(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: () {
//                                NavigatorUtils.goPersonRoute(context);
                              NavigatorUtils.goLoginRoute(context);
                              },
                              icon: Icon(
                                Icons.message,
                                size: 26,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                              label: Text(
                                "个人资料",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    fontSize: 12),
                              ),
                            ),
                            Container(
                              width: 18,
                            ),
                            FlatButton.icon(
                              onPressed: () {
                                NavigatorUtils.goOrderListRoute(context);
                              },
                              icon: Icon(
                                Icons.bookmark_border,
                                size: 26,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                              label: Text(
                                "我的订单",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    fontSize: 12),
                              ),
                            ),
                            Container(
                              width: 18,
                            ),
                            FlatButton.icon(
                              onPressed: () {
                                NavigatorUtils.goSettingRoute(context);
                              },
                              icon: Icon(
                                Icons.settings,
                                size: 26,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                              label: Text(
                                "设置",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      elevation: 4,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "我的",
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        margin: EdgeInsets.only(top: _statusbarHeight),
                        height: kToolbarHeight,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10 + kToolbarHeight + _statusbarHeight, left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipOval(
                          child: new Image.network(
                            "http://b-ssl.duitang.com/uploads/item/201607/13/20160713111911_WBxaK.thumb.1000_0.png",
                            width: 55,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            /// 判断是否登录:如果登录,填入用户名称,否则填写:登录/注册
                            "登录/注册",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      value: SystemUiOverlayStyle.light,
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return TemplateItem();
  }
  Future _onRefresh() async {
    page = 1;
    _onGetList();
  }

  bool isLoading = false; //是否正在加载数据
  int page = 1;

  Future _onGetList() async {
    if (isLoading) return;
    isLoading = true;
    await tbzHttpClient.getMyTemplateList()<List<TemplateBean>>(
        page: page++,
        uid: /*Global.profile.user.uid*/ 0,
        refresh: true,
        httpCallBack: (int code, data, String message) {
          print("USER_NAME" + data.length.toString());
          if (page == 2) {
            list.clear();
          }
          for (int i = 0; i < data.length; i++) {
            list.add(TemplateBean.fromJson(data[i]));
          }
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
