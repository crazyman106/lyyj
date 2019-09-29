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
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: Image.network(
        "https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1963559780,1216632413&fm=179&app=42&f=JPEG?w=121&h=140",
        width: 200,
        height: 100,
      ),
    );
  }
}
