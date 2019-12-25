import 'package:lyyj/widgets/home_found_item.dart';
import 'package:provider/provider.dart';

import '../index.dart';

/// 数据UI分离方式:
/// 1. bloc ( rxdart(stream) + streamBuilder)
/// 状态更改:
/// 1.Privider
/// 2.Redux
/// 3.EventBus
///
///
/// 主页:发现页面

class HomeFoundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFoundState();
  }
}

class HomeFoundState extends State<HomeFoundPage> {
  List<RecommendTemplate> list = new List(); //列表要展示的数据
  ScrollController _scrollController = ScrollController(); // 滑动控制器
  bool isLoading = false; //是否正在加载数据

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
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "妈妈的足迹",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: 10.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: 0.8),
          itemBuilder: _renderRow,
          itemCount: list.length,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return ChangeNotifierProvider<RecommendTemplate>.value(
      value: list[index],
      child: Consumer<RecommendTemplate>(builder: (context, value, child) {
        return FoundItem(
            (RecommendTemplate templateModel) {
              /// TODO page跳转
              Fluttertoast.showToast(msg: "您点击了第$index个");
            },
            list[index],
            (RecommendTemplate templateModel) {
              if (templateModel.isLike == 1) {
                Provider.of<RecommendTemplate>(context).setLike = 0;
              } else {
                Provider.of<RecommendTemplate>(context).setLike = 1;
              }
            });
      }),
    );
  }

  int page = 1;

  Future _onRefresh() async {
    page = 1;
    await _onGetList();
  }

  Future _onGetList() async {
    if (isLoading) return;
    isLoading = true;
    await tbzHttpClient.getRecommendList<List<RecommendTemplate>>(
        page: page++,
        uid: /*Global.profile.user.uid*/ 0,
        refresh: true,
        httpCallBack: (int code, data, String message) {
          print("USER_NAME" + data.length.toString());
          if (page == 2) {
            list.clear();
          }
          for (int i = 0; i < data.length; i++) {
            list.add(RecommendTemplate.fromJson(data[i]));
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
