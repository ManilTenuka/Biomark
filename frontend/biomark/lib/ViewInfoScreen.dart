import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // For handling JSON

class ViewInfoScreen extends StatefulWidget {
  final String email;  // Email to display
  final String userId; // User ID to display

  // Constructor to accept email and userId
  ViewInfoScreen({required this.email, required this.userId});

  @override
  _ViewInfoScreenState createState() => _ViewInfoScreenState();
}

class _ViewInfoScreenState extends State<ViewInfoScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _userInfo; // Store user info

  // Fetch user info from the server
  Future<void> _fetchUserInfo() async {
    final userId = widget.userId; // Get user ID from widget

    try {
      // Make the HTTP GET request to your backend API
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/view/$userId'), // Replace with your actual API endpoint
      );

      // Debugging: Log the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON response
        setState(() {
          _userInfo = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        // If the response is not OK, handle failure
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load user info'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      // Catch errors and show a snackbar
      setState(() {
        _isLoading = false;
      });
      print('Error: $error');  // Log the error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserInfo(); // Fetch user info when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Info', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[100], // Light background color for consistency
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching
            : _userInfo == null
            ? Center(child: Text('No user data found'))
            : Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'User Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Email inside the container
              _buildInfoRow('Email:', _userInfo!['email']),
              SizedBox(height: 10),

              // User ID inside the container
              _buildInfoRow('User ID:', _userInfo!['id'].toString()),
              SizedBox(height: 10),

              // Height
              _buildInfoRow('Height:', '${_userInfo!['height']} cm'),
              SizedBox(height: 10),

              // Ethnicity
              _buildInfoRow('Ethnicity:', _userInfo!['ethnicity']),
              SizedBox(height: 10),

              // Eye Color
              _buildInfoRow('Eye Color:', _userInfo!['eye_color']),
              SizedBox(height: 20),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Correctly use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build information rows
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.teal[700],
          ),
        ),
      ],
    );
  }
}
