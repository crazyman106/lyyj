import 'package:json_annotation/json_annotation.dart';

part 'template.g.dart';

@JsonSerializable()
class TemplateBean {
  TemplateBean();

  num templateId;
  String title;
  String thumbnailUrl;
  String classifyName;
  num edition;
  num createdAt;
  num printAt;
  num isEdit;
  num recommend;
  num boutique;
  num thumbnail_should_at;
  num thumbnail_updated_at;

  factory TemplateBean.fromJson(Map<String, dynamic> json) =>
      _$TemplateBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateBeanToJson(this);
}
