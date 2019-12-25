import 'package:rxdart/rxdart.dart';

import '../index.dart';

class FoundBloc {
  bool _requested = false;

  bool _isLoading = false;
  bool _isRefreshing = false;


  bool get loading => _isLoading;
  bool get refreshing=> _isRefreshing;

  ///是否已经请求完成
  bool get requested => _requested;

  ///rxdart 实现的 stream
  var _subject = PublishSubject<List<RecommendTemplate>>();

  Observable<List<RecommendTemplate>> get stream => _subject.stream;
  //根据数据库和网络返回数据
  Future<void> requestRefresh() async{

  }
}
