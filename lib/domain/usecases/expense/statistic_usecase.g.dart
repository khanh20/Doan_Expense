// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticParams _$StatisticParamsFromJson(Map<String, dynamic> json) =>
    StatisticParams(
      createdDate: DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$StatisticParamsToJson(StatisticParams instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
    };
