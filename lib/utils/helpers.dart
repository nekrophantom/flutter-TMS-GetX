import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tms_app/utils/api_config.dart';

class ResponsiveHelper{
  static double screenHeight(BuildContext context, double percentage){
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * percentage;
  }

  static double screenWidth(BuildContext context, double percentage){
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * percentage;
  }
}

class ApiService{
  
  String? url = dotenv.env["API_URL"];
  String? port = dotenv.env["PORT"];

  // static String baseUrl = '${dotenv.env["API_URL"]}:${dotenv.env["PORT"]}/api/';

  // static String baseUrl = '${dotenv.env["API_URL"]}/api/';

  apiUrl(String urlSegment) {
    return Uri.parse(ApiConfig.prodBaseUrl + urlSegment);
  }

  Future<http.Response> get(String endpoint, String token) async {
    final response = await http.get(apiUrl(endpoint), headers: {
      'Authorization' : 'Bearer $token'
    });
    return response;
  }

  Future<http.Response> post(String endpoint, dynamic data, String token) async {
    final response = await http.post(apiUrl(endpoint), body: data, headers: {
      'Content-Type'  : 'application/json',
      'Authorization' : 'Bearer $token'
    });
    return response;
  }

  Future<http.Response> put(String endpoint, dynamic data, String token) async {
    final response = await http.put(apiUrl(endpoint), body: data, headers: {
      'Authorization' : 'Bearer $token'
    });
    return response;
  }

  Future<http.Response> delete(String endpoint, String token) async {
    final response = await http.delete(apiUrl(endpoint), headers: {
      'Authorization' : 'Bearer $token'
    });
    return response;
  }
}