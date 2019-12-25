import 'package:flutter/services.dart';
import 'package:lyyj/common/style/lyyj_style.dart';

import '../index.dart';

class SettingRoute extends StatefulWidget {
  static final String sName = "Setting";

  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<SettingRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "设置",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(LYYJColors.primaryValue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            //INK可以实现装饰容器，实现矩形 设置背景色
            child: new Ink(
              //设置背景 默认矩形
//              color: Colors.white,
              decoration: new BoxDecoration(
                  //不能同时”使用Ink的变量color属性以及decoration属性，两个只能存在一个
                  color: Colors.white,
                  //设置圆角
                  border: Border(bottom: BorderSide(color: Colors.grey[300]))),
              child: new InkWell(
                //点击事件回调
                onTap: () {},
                child: new Container(
                  padding: EdgeInsets.only(left: 12, right: 6),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("关于我们"),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
