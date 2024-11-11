import 'package:flutter/material.dart';
import '../auth_service.dart';
import 'login_screen.dart'; // Import the Login screen here

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _timeOfBirthController = TextEditingController();
  final _locationOfBirthController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _sexController = TextEditingController();
  final _heightController = TextEditingController();
  final _ethnicityController = TextEditingController();
  final _eyeColorController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> _register() async {
    final response = await _authService.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
      _dateOfBirthController.text,
      _timeOfBirthController.text,
      _locationOfBirthController.text,
      _bloodGroupController.text,
      _sexController.text,
      double.tryParse(_heightController.text) ?? 0.0,
      _ethnicityController.text,
      _eyeColorController.text,
    );

    // Debugging: Print response details
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),
      );

      // Navigate to Login page after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Failed: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background color
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Username Field
              _buildTextField(_usernameController, 'Username'),
              SizedBox(height: 15),
              // Email Field
              _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 15),
              // Password Field
              _buildTextField(_passwordController, 'Password', obscureText: true),
              SizedBox(height: 15),
              // Date of Birth
              _buildTextField(_dateOfBirthController, 'Date of Birth (YYYY-MM-DD)', keyboardType: TextInputType.datetime),
              SizedBox(height: 15),
              // Time of Birth
              _buildTextField(_timeOfBirthController, 'Time of Birth (HH:MM:SS)', keyboardType: TextInputType.datetime),
              SizedBox(height: 15),
              // Location of Birth
              _buildTextField(_locationOfBirthController, 'Location of Birth'),
              SizedBox(height: 15),
              // Blood Group
              _buildTextField(_bloodGroupController, 'Blood Group'),
              SizedBox(height: 15),
              // Sex
              _buildTextField(_sexController, 'Sex'),
              SizedBox(height: 15),
              // Height
              _buildTextField(_heightController, 'Height (in cm)', keyboardType: TextInputType.number),
              SizedBox(height: 15),
              // Ethnicity
              _buildTextField(_ethnicityController, 'Ethnicity'),
              SizedBox(height: 15),
              // Eye Colour
              _buildTextField(_eyeColorController, 'Eye Colour'),
              SizedBox(height: 30),
              // Register Button
              ElevatedButton(
                onPressed: _register,
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button background color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Login Redirect Text
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account? Log in',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}
