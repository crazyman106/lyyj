import 'package:lyyj/common/style/lyyj_style.dart';

import '../index.dart';

class TabBarWidget extends StatefulWidget {
  ///底部模式type
  static final int BOTTOM_TAB = 1;

  ///顶部模式type
  final int TOP_TAB = 2;
  final int type;
  final bool resizeToAvoidBottomInset;
  bool showIndicator = false;
  Decoration indicator;
  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;
  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget bottomBar;
  final TarWidgetControl tarWidgetControl;

  final ValueChanged<int> onPageChanged;

  TabBarWidget(
      {Key key,
      this.type,
      this.tabItems,
      this.tabViews,
      this.backgroundColor,
      this.indicatorColor,
      this.title,
      this.drawer,
      this.bottomBar,
      this.floatingActionButtonLocation,
      this.floatingActionButton,
      this.resizeToAvoidBottomInset = true,
      this.tarWidgetControl,
      this.onPageChanged,
      this.showIndicator,
      this.indicator})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabBarState(
      type,
      tabViews,
      indicatorColor,
      drawer,
      floatingActionButton,
      tarWidgetControl,
      onPageChanged,
    );
  }
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  final int _type;

  final List<Widget> _tabViews;

  final Color _indicatorColor;

  final Widget _drawer;

  final Widget _floatingActionButton;

  final TarWidgetControl _tarWidgetControl;

  final PageController _pageController = PageController();

  final ValueChanged<int> _onPageChanged;
  TabController _tabController;

  _TabBarState(
    this._type,
    this._tabViews,
    this._indicatorColor,
    this._drawer,
    this._floatingActionButton,
    this._tarWidgetControl,
    this._onPageChanged,
  ) : super();

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this._type == widget.TOP_TAB) {
      return Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        floatingActionButton:
            SafeArea(child: _floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons:
            _tarWidgetControl == null ? null : _tarWidgetControl.footerButton,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: new TabBar(
              controller: _tabController,
              tabs: widget.tabItems,
              indicatorColor: _indicatorColor,
              onTap: (index) {
                _onPageChanged?.call(index);
                _pageController
                    .jumpTo(MediaQuery.of(context).size.width * index);
              }),
        ),
        body: new PageView(
          controller: _pageController,
          children: _tabViews,
          onPageChanged: (index) {
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }

    ///底部tab bar
    return new Scaffold(
        drawer: _drawer,
        appBar:
            null /*new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
        )*/
        ,
        body: new PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _tabViews,
          onPageChanged: (index) {
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
        bottomNavigationBar: new Material(
          //为了适配主题风格，包一层Material实现风格套用
          color: /*Theme.of(context).primaryColor*/ Color(LYYJColors.white),
          //底部导航栏主题颜色
          child: new SafeArea(
            child: new TabBar(
              //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
              controller: _tabController,
              //配置控制器
              tabs: widget.tabItems,
              unselectedLabelColor: Color(LYYJColors.gray),
              indicator: widget.indicator,
              labelStyle: TextStyle(fontSize: 12),
              labelColor: Color(LYYJColors.primaryValue),
              indicatorColor: _indicatorColor,
              onTap: (index) {
                _onPageChanged?.call(index);
                _pageController
                    .jumpTo(MediaQuery.of(context).size.width * index);
              }, //tab标签的下划线颜色
            ),
          ),
        ));
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
