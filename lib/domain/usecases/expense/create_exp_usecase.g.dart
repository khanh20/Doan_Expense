// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_exp_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExpParams _$CreateExpParamsFromJson(Map<String, dynamic> json) =>
    CreateExpParams(
      categoryId: (json['categoryId'] as num).toInt(),
      amount: Decimal.fromJson(json['amount'] as String),
      createdDate: DateTime.parse(json['createdDate'] as String),
      description: json['description'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$CreateExpParamsToJson(CreateExpParams instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'createdDate': instance.createdDate.toIso8601String(),
      'description': instance.description,
      'type': instance.type,
      'categoryId': instance.categoryId,
    };
