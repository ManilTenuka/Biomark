import 'package:flutter/material.dart';
import '../auth_service.dart'; // Assuming you have a service for API calls
import 'dart:convert'; // For handling JSON

class UpdateInfoScreen extends StatefulWidget {
  final String userId;  // User ID to update
  final String email;   // Email to update

  // Constructor to accept userId and email
  UpdateInfoScreen({required this.userId, required this.email});

  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _heightController = TextEditingController();
  final _ethnicityController = TextEditingController();
  final _eyeColorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;  // Set the initial email
  }

  Future<void> _updateInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final height = _heightController.text;
      final ethnicity = _ethnicityController.text;
      final eyeColor = _eyeColorController.text;

      final userId = widget.userId;  // Get userId passed from HomeScreen

      // Console log the data before sending to the API
      print('Sending data to API:');
      print('ID: $userId');
      print('Email: $email');
      print('Password: $password');
      print('Height: $height');
      print('Ethnicity: $ethnicity');
      print('Eye Color: $eyeColor');

      // Sending the data to your API
      final response = await _authService.updateUserInfo(
        userId,
        email,
        password,
        height,
        ethnicity,
        eyeColor,
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User info updated successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update user info'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Info'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Password field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Height field
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: 'Height (in cm)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Height is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Ethnicity field
              TextFormField(
                controller: _ethnicityController,
                decoration: InputDecoration(
                  labelText: 'Ethnicity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ethnicity is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Eye color field
              TextFormField(
                controller: _eyeColorController,
                decoration: InputDecoration(
                  labelText: 'Eye Color',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Eye color is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),

              // Submit button
              ElevatedButton(
                onPressed: _updateInfo,
                child: Text('Update Info'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal, // Set background color here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
