import '../index.dart';

class HomeFoundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFoundState();
  }
}

class HomeFoundState extends State<HomeFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: Text("发现"),
    );
  }
}
