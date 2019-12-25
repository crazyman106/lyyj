import 'package:provider/provider.dart';

import '../index.dart';

typedef CollectionCallback = void Function(RecommendTemplate templateModel);
typedef ItemCallback = void Function(RecommendTemplate templateModel);

class FoundItem extends StatelessWidget {
  final ItemCallback onPressed;
  final RecommendTemplate beanModel;
  final CollectionCallback onCollectPressed;

  FoundItem(@required this.onPressed, @required this.beanModel,
      @required this.onCollectPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () => onPressed(beanModel),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.network(
                  "https:" + beanModel.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 30,
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    onCollectPressed(beanModel);
                  },

                  /// isLike 0:未点赞;1:点赞;
                  icon: Image.asset(
                    Provider.of<RecommendTemplate>(context).isLike == 0
                        ? "images/icon_zan_no.png"
                        : "images/icon_zan_ok.png",
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                  label: Text(
                    Provider.of<RecommendTemplate>(context)
                        .likeNumber
                        .toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
