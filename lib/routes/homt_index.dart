import 'package:flutter_swiper/flutter_swiper.dart';

import '../index.dart';

class HomeIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeIndexState();
  }
}

class HomeIndexState extends State<HomeIndexPage> {
  @override
  Widget build(BuildContext context) {
    List<String> bannerDatas = [
      "http://file.youdianpinwei.com/ypw/1c0f07ab-201a-410d-bc27-c87a54f21dfc.jpg",
      "http://file.youdianpinwei.com/ypw/4914baf8-cfce-4acc-84f9-12513591bc20.jpg",
      "http://file.youdianpinwei.com/ypw/a5ffab2a-4264-4d70-b170-fb691ea07cd5.jpg"
    ];
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: Swiper(
              itemCount: bannerDatas.length,
              //item数量
              itemBuilder: (BuildContext context, int index) {
                //item构建
                return new Image.network(
                  bannerDatas[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              //是否自动播放
              autoplayDelay: 3000,
              //自动播放延迟
              autoplayDisableOnInteraction: true,
              //触发时是否停止播放
              duration: 600,
              //动画时间
              control: null,
              //默认指示器
              pagination: null,
              viewportFraction: 1,
              //视图宽度，即显示的item的宽度屏占比
              scale: 1,
              //两侧item的缩放比
              onTap: (int index) {
                //点击事件，返回下标
                print("index-----" + index.toString());
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: .0, left: 12.0, right: 12.0),
            padding: EdgeInsets.only(left: 0, top: 16, right: 0, bottom: 10),
            constraints: BoxConstraints.tightForFinite(
                width: MediaQuery.of(context).size.width, height: 268),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFCCCCCC),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 8.0,
                    spreadRadius: -3.0),
              ],
              // 边色与边宽度
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/index_product_left.png",
                      width: 22,
                      height: 22,
                    ),
                    Text(
                      "   优秀作品展示   ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      "images/index_product_right.png",
                      width: 22,
                      height: 22,
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  margin: EdgeInsets.only(top: 14),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: _buildItem,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(5)),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(5),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFff5350),
                            Color(0xFFD32F2F),
                          ],
                          begin: FractionalOffset(0, 0),
                          end: FractionalOffset(0, 1),
                        ),
                      ),
                      child: Container(
                        width: 220,
                        height: 55,
                        child: FlatButton(
                          child: Text(
                            "立即制作",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(5)),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
              padding: EdgeInsets.only(left: 10, top: 16, right: 10, bottom: 0),
              constraints: BoxConstraints.tightForFinite(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFCCCCCC),
                      offset: Offset(0.0, -5.0),
                      blurRadius: 8.0,
                      spreadRadius: -3.0),
                ],
                /* border: new Border(
                    bottom: BorderSide(color: Color(0xFFFFFFFF), width: 0),
                    left: BorderSide(color: Color(0xFFE9E9E9), width: 0.5),
                    right: BorderSide(color: Color(0xFFE9E9E9), width: 0.5),
                    top: BorderSide(color: Color(0xFFE9E9E9), width: 0.5)),*/
                // 边色与边宽度
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.all(0),
                            elevation: 4,
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 54) / 2,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF799B9),
                                    Color(0xFFFA6799),
                                  ],
                                  begin: FractionalOffset(0, 0),
                                  end: FractionalOffset(0, 1),
                                ),
                              ),
                              child: FlatButton(
                                child: Text(
                                  "妈妈与美丽",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(left: 10),
                            elevation: 4,
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 54) / 2,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF87ABE7),
                                    Color(0xFF628ECF),
                                  ],
                                  begin: FractionalOffset(0, 0),
                                  end: FractionalOffset(0, 1),
                                ),
                              ),
                              child: FlatButton(
                                child: Text(
                                  "妈妈与旅游",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.all(0),
                            elevation: 4,
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 54) / 2,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF80DBD2),
                                    Color(0xFF4FD5CB),
                                  ],
                                  begin: FractionalOffset(0, 0),
                                  end: FractionalOffset(0, 1),
                                ),
                              ),
                              child: FlatButton(
                                child: Text(
                                  "妈妈与健康",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(left: 10),
                            elevation: 4,
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 54) / 2,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF9C945),
                                    Color(0xFFFFBE03),
                                  ],
                                  begin: FractionalOffset(0, 0),
                                  end: FractionalOffset(0, 1),
                                ),
                              ),
                              child: FlatButton(
                                child: Text(
                                  "经典故事",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8)),
        elevation: 4,
        margin: _insetsGeometry(index),
        child: Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(8),
            image: DecorationImage(
              alignment: Alignment.topRight,
              fit: BoxFit.cover,
              image: NetworkImage(
                  'http://file.youdianpinwei.com/ypw/1c0f07ab-201a-410d-bc27-c87a54f21dfc.jpg'),
            ),
          ),
          child: Container(
            width: 160,
            height: 100,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5)),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _insetsGeometry(int index) {
    if (index == 0)
      return EdgeInsets.only(left: 10.0, top: 10.0, right: 5.0, bottom: 10);
    if (index == 4)
      return EdgeInsets.only(left: 5, top: 10.0, right: 10.0, bottom: 10);
    else
      return EdgeInsets.only(left: 5, top: 10.0, right: 5.0, bottom: 10);
  }
}
