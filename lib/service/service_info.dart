import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:second_app/config/api_config.dart';
import 'package:second_app/models/delete.dart';
import 'package:second_app/models/login.dart';
import 'package:second_app/models/update.dart';
import 'package:second_app/models/user.dart';
import 'package:second_app/models/verify.dart';

class ServiceInfo {
  Future<Login?> loginUser(String phoneNumber) async {
    final url = Uri.parse(ApiConfig.baseUrl + ApiConfig.login);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'phoneNumber': phoneNumber});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        return Login.fromJson(jsonData);
      } else {
        print('Failed to load data. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<Verify?> verifyOtp(String phoneNumber, String otp) async {
    final url = Uri.parse(ApiConfig.baseUrl + ApiConfig.verify);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phoneNumber': phoneNumber, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Verify.fromJson(jsonResponse);
      } else {
        /// Handle error response
        print('Failed to verify OTP: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred while verifying OTP: $e');
      return null;
    }
  }

  static Future<User?> fetchUserData(String accessToken) async {
    final url = Uri.parse(ApiConfig.baseUrl + ApiConfig.user);
    final headers = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      // Handle error response
      return null;
    }
  }

  static Future<Update> updateUserData(
    String accessToken,
    String name,
    String gender,
    String placeOfBirth,
    String status,
    DateTime dateOfBirth,
    TimeOfDay timeOfBirth,
  ) async {
    final String dateOfBirthIso =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(dateOfBirth);
    final DateTime combinedDateTime = DateTime(
      dateOfBirth.year,
      dateOfBirth.month,
      dateOfBirth.day,
      timeOfBirth.hour,
      timeOfBirth.minute,
      0,
    );
    final String timeOfBirthIso =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(combinedDateTime);
    final url = Uri.parse(ApiConfig.baseUrl + ApiConfig.update);

    final Map<String, dynamic> requestData = {
      'name': name,
      'gender': gender,
      'place_of_birth': placeOfBirth,
      'date_of_birth': dateOfBirthIso,
      'time_of_birth': timeOfBirthIso,
      'status': status,
    };
    final headers = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(requestData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Update.fromJson(responseData);
    } else {
      throw Exception('Failed to update user data: ${response.reasonPhrase}');
    }
  }

  static Future<Delete> deleteUser(String accessToken) async {
    final url = Uri.parse(ApiConfig.baseUrl + ApiConfig.delete);

    final headers = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Delete.fromJson(responseData);
    } else {
      throw Exception('Failed to delete user: ${response.reasonPhrase}');
    }
  }
}
