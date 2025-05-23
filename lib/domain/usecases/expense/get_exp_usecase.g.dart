// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exp_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExpParams _$GetExpParamsFromJson(Map<String, dynamic> json) => GetExpParams(
      amount: json['amount'] == null
          ? null
          : Decimal.fromJson(json['amount'] as String),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      description: json['description'] as String?,
      type: json['type'] as String?,
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$GetExpParamsToJson(GetExpParams instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'createdDate': instance.createdDate?.toIso8601String(),
      'description': instance.description,
      'type': instance.type,
      'keyword': instance.keyword,
    };
