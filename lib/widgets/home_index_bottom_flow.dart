import '../index.dart';

class HomeIndexBottomFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  HomeIndexBottomFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    // implement paintChildren
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w <= context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(double.infinity, double.infinity);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // implement shouldRepaint
    return oldDelegate!= this;
  }
}
