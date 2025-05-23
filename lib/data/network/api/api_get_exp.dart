import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/data/network/constants/api_constant.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/di/service_locator.dart';

class ApiGetExp {
  final RestClient _restClient = getIt<RestClient>();
  final SharedPreferenceHelper _sharedPrefHelper =
      getIt<SharedPreferenceHelper>();
  ApiGetExp();

  Future<Map<String, dynamic>> getExp({String? keyword,String? description,Decimal? amount,DateTime? createDate,String? type}) async {
    final token = await _sharedPrefHelper.authToken;

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',

    };
    final response = await _restClient.get(
      "${APIConstants.api}expense/get-all",
      params: {"keyword": keyword},
      headers: headers,
    );
      print("aapiii: ${APIConstants.api}expense/get-all?keyword=${keyword}");

    return response;
  }
}
