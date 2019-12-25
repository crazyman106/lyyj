import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lyyj/common/redux/lyyj_state.dart';
import 'package:lyyj/common/style/lyyj_style.dart';

import '../index.dart';

/**
 * await关键字必须在async函数内部使用
 * 调用async函数必须使用await关键字
 */
class LoginRoute extends StatefulWidget {
  static final String sName = "login";

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginRoute> {
  var _phone = "";
  var _verifycode = "";
  TextEditingController phoneController = TextEditingController();
  TextEditingController verifyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _verifyStr = "获取验证码";
    _phone = await Global.profile.user.username;
    phoneController.value = new TextEditingValue(text: _phone ?? "");
    verifyController.value = new TextEditingValue(text: _verifycode ?? "");
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);

    ///共享 store
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: StoreBuilder<LYYJState>(builder: (context, store) {
        /// 触摸收起键盘
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            body: Container(
                color: Colors.white,
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: height / 3,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                alignment: Alignment.center,
                                child: FlatButton.icon(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  label: Text(""),
                                  icon: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Color(LYYJColors.primaryValue),
                                  ),
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                ),
                                width: kToolbarHeight,
                                height: kToolbarHeight,
                              ),
                              left: 0,
                              top: 0,
                            ),
                            Positioned(
                              left: 16,
                              top: kToolbarHeight + 6,
                              child: Text(
                                "登陆/注册",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff666666)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 40),
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                "images/logo.png",
                                width: 70,
                                height: 70,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: height / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                controller: phoneController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 5),
                                  hintText: '请输入你的手机号',
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                cursorWidth: 2,
                                cursorRadius: Radius.circular(2.0),
//                        maxLength: 11,
                                maxLines: 1,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11),
                                  WhitelistingTextInputFormatter.digitsOnly,
                                ],
                                cursorColor: Color(LYYJColors.primaryValue),
                                onChanged: (value) {
                                  _phone = value;
                                },
                              ),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, top: 0, bottom: 14),
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: Stack(
                                children: <Widget>[
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    controller: verifyController,
                                    decoration: InputDecoration(
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      hintText: '请输入验证码',
                                    ),
                                    //只能输入数字
                                    cursorColor: Color(LYYJColors.primaryValue),
                                    cursorWidth: 2,
                                    cursorRadius: Radius.circular(2.0),
//                        maxLength: 6,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6),
                                      WhitelistingTextInputFormatter.digitsOnly,
                                    ],
                                    maxLines: 1,
                                    maxLengthEnforced: true,
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      _login;
                                    },
                                    onChanged: (value) {
                                      _verifycode = value;
                                    },
                                  ),
                                  Positioned(
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      elevation: 1,
                                      color: Colors.transparent,
                                      child: Container(
                                        width: 80,
                                        height: 22.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  2),
                                          color: Color(LYYJColors.primaryValue),
                                        ),
                                        child: FlatButton(
                                          child: Text(
                                            '$_verifyStr',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_phone.length != 11) {
                                              Fluttertoast.showToast(
                                                  msg: "请检查手机号是否正确");
                                              return;
                                            }
                                            if (_seconds == 0) {
                                              _verify;
                                              setState(() {
                                                _startTimer();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    right: 0,
                                    bottom: 6,
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, top: 32, bottom: 26),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 20),
                              child: Card(
                                margin: EdgeInsets.all(0),
                                elevation: 4,
                                color: Colors.transparent,
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 54) /
                                          2,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(5),
                                    color: Color(LYYJColors.primaryValue),
                                  ),
                                  child: FlatButton(
                                    child: Text(
                                      "登陆",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      if (_phone.length != 11 &&
                                          _verifycode.length != 6) {
                                        Fluttertoast.showToast(
                                            msg: "请检查手机号和验证码是否正确");
                                        return;
                                      }
                                      _login();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height / 3,
                        padding: EdgeInsets.only(bottom: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(msg: "微信登录");
                                },
                                child: new Container(
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/login_wx.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(
                                "微信登录",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "登录注册即表明你已阅读并同意妈妈的足迹",
                                style: TextStyle(
                                    color: Color(0xff999999), fontSize: 12.0),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '《服务协议》 ',
                                    style: TextStyle(
                                      color: Color(LYYJColors.primaryValue),
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Fluttertoast.showToast(
                                            msg: "点击了富文本展示页面");
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      }),
    );
  }

  var _seconds = 0;

  var _timer;
  var _verifyStr;

  _startTimer() {
    _seconds = 60;
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _verifyStr = '$_seconds s';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  /// 登录
  _login() {}

  /// 获取验证码
  _verify() {}

  @override
  void dispose() {
    super.dispose();
    verifyController.dispose();
    phoneController.dispose();
  }
}
