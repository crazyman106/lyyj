import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class LYYJResponse<T> {
  LYYJResponse();

  T Data;
  int Code;
  String Message;


  factory LYYJResponse.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
