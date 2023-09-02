import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
  static String baseUrl = '${dotenv.env["API_URL"]}:${dotenv.env["PORT"]}/api/';

  apiUrl(String urlSegment) {
    return Uri.parse(baseUrl + urlSegment);
  }

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(apiUrl(endpoint));
    return response;
  }

  Future<http.Response> post(String endpoint, dynamic data) async {
    final response = await http.post(apiUrl(endpoint), body: data);
    // final respose = apiUrl(endpoint);
    return response;
  }

  Future<http.Response> put(String endpoint, dynamic data) async {
    final response = await http.put(apiUrl(endpoint), body: data);
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(apiUrl(endpoint));
    return response;
  }
}