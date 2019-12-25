import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  String token;
  String username;
  String avator;
  String mobile;
  String birthday;
  @JsonKey(name:"UID")
  int uid;

  // 命名构造函数
  User.empty();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
