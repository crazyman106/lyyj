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
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: .0, left: 12.0, right: 12.0),
            padding: EdgeInsets.only(left: 10, top: 16, right: 10, bottom: 10),
            constraints: BoxConstraints.tightForFinite(width: 400, height: 250),
            decoration: BoxDecoration(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
