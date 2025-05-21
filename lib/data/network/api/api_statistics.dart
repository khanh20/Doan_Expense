import 'dart:async';
import 'package:flutter_application_1/data/network/constants/api_constant.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/di/service_locator.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';

class ApiStatistics {
  final RestClient _restClient = getIt<RestClient>();
  final SharedPreferenceHelper _sharedPrefHelper = getIt<SharedPreferenceHelper>();

  ApiStatistics();

  Future<Map<String, dynamic>> statistics(
    DateTime createdDate,
  ) async {
    final token = await _sharedPrefHelper.authToken;

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await _restClient.get(
      "${APIConstants.api}expense/statistics?createdDate=${createdDate.toIso8601String()}",
   
      headers: headers, 
    );

    return response;
  }
}
