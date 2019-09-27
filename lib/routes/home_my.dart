import '../index.dart';

class HomeMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeMyState();
  }
}

class HomeMyState extends State<HomeMyPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: new Image(
          image: new AssetImage("images/main_bottom_found_normal.png"),
          width: 80.0,
          height: 80.0)
    );
  }
}
