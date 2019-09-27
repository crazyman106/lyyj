import '../index.dart';

class TitleBar extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPressed;
  final bool needRightLocalIcon;
  final Widget rightWidget;

  TitleBar(this.title,
      {this.iconData,
      this.onPressed,
      this.needRightLocalIcon = false,
      this.rightWidget});

  @override
  Widget build(BuildContext context) {
    Widget widget = rightWidget;

    rightWidget ?? (needRightLocalIcon)
        ? new IconButton(
            icon: new Icon(
              iconData,
              size: 19.0,
            ),
            onPressed: onPressed)
        : new Container();

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget
        ],
      ),
    );
  }
}
