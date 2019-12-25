import 'package:lyyj/common/style/lyyj_style.dart';

import '../index.dart';

class TemplateItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 4,
        child: Container(
          height: 110,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 12, top: 10),
                height: 80,
                width: 125,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                        width: 125,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 125,
                      height: 16,
                      alignment: Alignment.center,
                      //88000000
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.zero,
                            topLeft: Radius.zero,
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        color: Color.fromARGB(88, 0, 0, 0),
                      ),
                      child: Text(
                        "生成中",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
//                margin: EdgeInsets.only(top: 6, right: 6, left: 140),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 142,
                      top: 6,
                      child: Text(
                        "妈妈的足迹",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(top: 10, right: 10),
                      // 显示渲染中,就有padding,否则,为0
                      child:
                          /*SizedBox(
                        width: 60,
                        height: 35,
                        child: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: LYYJColors.primarySwatch,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      )*/
                          Image.asset(
                        "images/my_template_rendering.png",
                        width: 40,
                        height: 30,
                      ),
                    ),
                    Positioned(
                      left: 142,
                      top: 68,
                      child: Wrap(
                        spacing: 6,
                        children: <Widget>[
                          SizedBox(
                            width: 48,
                            height: 22,
                            child: FlatButton(
                              //child按钮中的内容
                              child: Text("印刷",style: TextStyle(fontSize: 14),),
                              //文字颜色
                              textColor: Color(LYYJColors.primaryLightValue),
                              //按钮禁用时的文字颜色
                              disabledTextColor: Colors.red,
                              //点击时，水波动画中水波的颜色
                              splashColor: Colors.black12,
                              //内边距
                              padding: EdgeInsets.all(0),
                              ////按钮主题，默认是浅色主题
                              colorBrightness: Brightness.dark,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.5,color: Color(LYYJColors.primaryLightValue)),
                                  borderRadius: BorderRadius.circular(10.0)),
                              //外形
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 48,
                            height: 22,
                            child: FlatButton(
                              //child按钮中的内容
                              child: Text("印刷",style: TextStyle(fontSize: 14),),
                              //文字颜色
                              textColor: Color(LYYJColors.primaryLightValue),
                              //按钮禁用时的文字颜色
                              disabledTextColor: Colors.red,
                              //点击时，水波动画中水波的颜色
                              splashColor: Colors.black12,
                              //内边距
                              padding: EdgeInsets.all(0),
                              ////按钮主题，默认是浅色主题
                              colorBrightness: Brightness.dark,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.5,color: Color(LYYJColors.primaryLightValue)),
                                  borderRadius: BorderRadius.circular(10.0)),
                              //外形
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
