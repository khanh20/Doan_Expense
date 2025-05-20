import 'dart:async';
import 'package:flutter_application_1/data/network/constants/api_constant.dart';
import 'package:flutter_application_1/data/network/rest_client.dart';
import 'package:flutter_application_1/di/service_locator.dart';

class ApiGetCategory {
  final RestClient _restClient = getIt<RestClient>();

  ApiGetCategory( );


  Future<Map<String, dynamic>> getCategories() async {
      final response = await _restClient.get(
        "${APIConstants.api}category/get-all",
      );
      print("Response data: $response");
      return response;
  }
}
