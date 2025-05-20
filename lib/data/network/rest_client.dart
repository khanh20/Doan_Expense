import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exceptions/network_exceptions.dart';

class RestClient {
  
  // GET 
  Future<dynamic> get(String path) async {
    try {
      final response = await http.get(Uri.parse(path));
      return _createResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // POST 
  Future<dynamic> post(String path, {Map<String, dynamic>? data,Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(path),
        body: jsonEncode(data),
        headers:headers ?? {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return _createResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // PUT 
  Future<dynamic> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await http.put(
        Uri.parse(path),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          
        },
      );
      return _createResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // DELETE 
  Future<dynamic> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await http.delete(
        Uri.parse(path),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return _createResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // Xử lý response
 dynamic _createResponse(http.Response response) {
  final String res = response.body;
  final int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode >= 400) {
    try {
      final decoded = json.decode(res);

      if (decoded is Map<String, dynamic>) {
        final errorMessage = decoded['error'] ?? decoded['message'] ?? res;
        throw NetworkException(message: errorMessage, statusCode: statusCode);
      } else if (decoded is String) {
        throw NetworkException(message: decoded, statusCode: statusCode);
      } else {
        throw NetworkException(message: res, statusCode: statusCode);
      }
    } catch (e) {
      throw NetworkException(
        message: res.replaceAll('"', ''), 
        statusCode: statusCode,
      );
    }
  }

  try {
    return json.decode(res);
  } catch (e) {
    throw NetworkException(
      message: 'Không thể giải mã dữ liệu trả về',
      statusCode: statusCode,
    );
  }
}


}
