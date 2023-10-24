import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Models/getAccountInformation.dart';

class ApiService {
  final String baseUrl = 'https://peanut.ifxdb.com';

  Future<Map<String, dynamic>> fetchLoginData(String userName, String password) async {
    final url = Uri.parse('$baseUrl/api/ClientCabinetBasic/IsAccountCredentialsCorrect');
    final headers = {
      'Content-Type': 'application/json-patch+json',
    };
    final body = jsonEncode({
      'login': userName,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the response data to check if the login is successful
        bool isLoginSuccessful = data['result'] == true;

        if (isLoginSuccessful) {
          String token = data['token'];
          return {'success': true, 'token': token};
        } else {
          return {'success': false, 'message': 'Login unsuccessful'};
        }
      } else if (response.statusCode == 401) {
        return {'success': false, 'message': 'Unauthorized: ${response.body}'};
      } else {
        return {'success': false, 'message': 'API Error: ${response.statusCode}'};
      }
    } catch (error) {
      return {'success': false, 'message': 'API Request Error: $error'};
    }
  }

  Future<AccountInformation> getAccountInformation(String login, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/ClientCabinetBasic/GetAccountInformation'),
        headers: {
          'Content-Type': 'application/json-patch+json',
        },
        body: json.encode({
          'login': int.parse(login),
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Account Information Data: $data'); // Print the data
        return AccountInformation.fromJson(data);
      } else {
        throw Exception('Failed to load account information');
      }
    } catch (error) {
      throw Exception('API Request Error: $error');
    }
  }


  Future<String> getLastFourNumbersOfPhone(String login, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/GetLastFourNumbersPhone'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load last four numbers of the phone');
    }
  }
}

