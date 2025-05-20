import 'dart:async';
import 'package:flutter_application_1/data/network/constants/api_constant.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/di/service_locator.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart'; // import thêm
import 'package:decimal/decimal.dart';

class ApiCreateExp {
  final RestClient _restClient = getIt<RestClient>();
  final SharedPreferenceHelper _sharedPrefHelper = getIt<SharedPreferenceHelper>();

  ApiCreateExp();

  Future<Map<String, dynamic>> createExp(
    Decimal amount,
    String description,
    DateTime createdDate,
    String type,
    int categoryId,
  ) async {
    final token = await _sharedPrefHelper.authToken;

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await _restClient.post(
      "${APIConstants.api}expense/create",
      data: {
        "amount": amount.toString(),
        "description": description,
        "createdDate": createdDate.toIso8601String(),
        "type": type,
        "categoryId": categoryId,
      },
      headers: headers, 
    );

    return response;
  }
}
