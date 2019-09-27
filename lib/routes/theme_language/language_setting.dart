import 'package:flutter_redux/flutter_redux.dart';
import 'package:lyyj/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../index.dart';

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme
        .of(context)
        .primaryColor;
    List<String> list = [
      Global.getLocale(context).home_language_default,
      Global.getLocale(context).home_language_zh,
      Global.getLocale(context).home_language_en,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(Global
            .getLocale(context)
            .language),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                list[index],
                // 对APP当前语言进行高亮显示
                style: TextStyle(
                    color: Global.getLocale(context) == list[index] ? color : null),
              ),
              trailing:
              Global.getLocale(context) == list[index]
                  ? Icon(Icons.done, color: color)
                  : null,
              onTap: () {
                // 此行代码会通知MaterialApp重新build
                LocaleModel.changeLocale(StoreProvider.of(context), index);
              },
            );
          }
      ),
    );
  }
}
