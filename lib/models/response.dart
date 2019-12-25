import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class LYYJResponse {
    LYYJResponse();

    var Data;
    num Code;
    String Message;
    
    factory LYYJResponse.fromJson(Map<String,dynamic> json) => _$LYYJResponseFromJson(json);
    Map<String, dynamic> toJson() => _$LYYJResponseToJson(this);
}
