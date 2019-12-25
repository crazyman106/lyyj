// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateBean _$TemplateBeanFromJson(Map<String, dynamic> json) {
  return TemplateBean()
    ..templateId = json['templateId'] as num
    ..title = json['title'] as String
    ..thumbnailUrl = json['thumbnailUrl'] as String
    ..classifyName = json['classifyName'] as String
    ..edition = json['edition'] as num
    ..createdAt = json['createdAt'] as num
    ..printAt = json['printAt'] as num
    ..isEdit = json['isEdit'] as num
    ..recommend = json['recommend'] as num
    ..boutique = json['boutique'] as num
    ..thumbnail_should_at = json['thumbnail_should_at'] as num
    ..thumbnail_updated_at = json['thumbnail_updated_at'] as num;
}

Map<String, dynamic> _$TemplateBeanToJson(TemplateBean instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'classifyName': instance.classifyName,
      'edition': instance.edition,
      'createdAt': instance.createdAt,
      'printAt': instance.printAt,
      'isEdit': instance.isEdit,
      'recommend': instance.recommend,
      'boutique': instance.boutique,
      'thumbnail_should_at': instance.thumbnail_should_at,
      'thumbnail_updated_at': instance.thumbnail_updated_at
    };
