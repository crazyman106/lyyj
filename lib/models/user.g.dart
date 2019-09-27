// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..token = json['token'] as String
    ..username = json['username'] as String
    ..avator = json['avator'] as String
    ..mobile = json['mobile'] as String
    ..birthday = json['birthday'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'avator': instance.avator,
      'mobile': instance.mobile,
      'birthday': instance.birthday
    };
