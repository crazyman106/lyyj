// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecommendTemplate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendTemplate _$RecommendTemplateFromJson(Map<String, dynamic> json) {
  return RecommendTemplate()
    ..templateId = json['templateId'] as num
    ..title = json['title'] as String
    ..thumbnailUrl = json['thumbnailUrl'] as String
    ..edition = json['edition'] as num
    ..createdAt = json['createdAt'] as num
    ..printAt = json['printAt'] as num
    ..recommend = json['recommend'] as num
    ..boutique = json['boutique'] as num
    ..likeNumber = json['likeNumber'] as num
    ..thumbnail_should_at = json['thumbnail_should_at'] as num
    ..thumbnail_updated_at = json['thumbnail_updated_at'] as num
    ..isLike = json['isLike'] as num
    ..coopUid = json['coopUid'] as String
    ..headimg = json['headimg'] as String
    ..username = json['username'] as String
    ..uid = json['uid'] as num;
}

Map<String, dynamic> _$RecommendTemplateToJson(RecommendTemplate instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'edition': instance.edition,
      'createdAt': instance.createdAt,
      'printAt': instance.printAt,
      'recommend': instance.recommend,
      'boutique': instance.boutique,
      'likeNumber': instance.likeNumber,
      'thumbnail_should_at': instance.thumbnail_should_at,
      'thumbnail_updated_at': instance.thumbnail_updated_at,
      'isLike': instance.isLike,
      'coopUid': instance.coopUid,
      'headimg': instance.headimg,
      'username': instance.username,
      'uid': instance.uid
    };
