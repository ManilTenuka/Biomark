import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Base URL for the API on Android Emulator
  final String baseUrl = 'http://10.0.2.2:3000';

  // Registration function extended to handle new fields
  Future<http.Response> register(
      String username,
      String email,
      String password,
      String dateOfBirth,
      String timeOfBirth,
      String locationOfBirth,
      String bloodGroup,
      String sex,
      double height,
      String ethnicity,
      String eyeColour,
      ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),  // Directly calling /register
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'email': email,
        'password': password,
        'date_of_birth': dateOfBirth,
        'time_of_birth': timeOfBirth,
        'location_of_birth': locationOfBirth,
        'blood_group': bloodGroup,
        'sex': sex,
        'height': height,
        'ethnicity': ethnicity,
        'eye_colour': eyeColour,
      }),
    );

    if (response.statusCode == 201) {
      print('Registration Successful');
    } else {
      print('Registration Failed: ${response.body}');
    }
    return response;
  }

  // Login function remains unchanged
  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),  // Directly calling /login
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return response;
  }
  Future<http.Response> updateUserInfo(
      String userId,
      String email,
      String password,
      String height,
      String ethnicity,
      String eyeColor,
      ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': userId,
        'email': email,
        'password': password,
        'height': height,
        'ethnicity': ethnicity,
        'eyeColor': eyeColor,
      }),
    );

    return response;
  }
}
