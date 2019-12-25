import 'package:json_annotation/json_annotation.dart';

import '../index.dart';

part 'RecommendTemplate.g.dart';

@JsonSerializable()
class RecommendTemplate extends ChangeNotifier {
  RecommendTemplate();

  num templateId;
  String title;
  String thumbnailUrl;
  num edition;
  num createdAt;
  num printAt;
  num recommend;
  num boutique;
  num likeNumber;
  num thumbnail_should_at;
  num thumbnail_updated_at;
  num isLike;
  String coopUid;
  String headimg;
  String username;
  num uid;

  set setLike(int isLike) {
    this.isLike = isLike;
    if (isLike == 0) {
      --likeNumber;
    } else {
      ++likeNumber;
    }
    notifyListeners();
  }

  factory RecommendTemplate.fromJson(Map<String, dynamic> json) =>
      _$RecommendTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendTemplateToJson(this);
}
