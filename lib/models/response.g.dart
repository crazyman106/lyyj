// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LYYJResponse _$ResponseFromJson(Map<String, dynamic> json) {
  return LYYJResponse()
    ..Data = json['Data']
    ..Code = json['Code'] as num
    ..Message = json['Message'] as String;
}

Map<String, dynamic> _$ResponseToJson(LYYJResponse instance) => <String, dynamic>{
      'Data': instance.Data,
      'Code': instance.Code,
      'Message': instance.Message
    };
