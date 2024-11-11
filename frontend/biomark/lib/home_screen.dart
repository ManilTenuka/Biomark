import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_info_screen.dart';
import 'ViewInfoScreen.dart';
import 'about_screen.dart'; // Import the AboutScreen

class HomeScreen extends StatelessWidget {
  final String email;  // Email to display
  final String userId; // User ID to display

  // Constructor to accept email and userId
  HomeScreen({required this.email, required this.userId});

  // Method to delete user info
  Future<void> _deleteUser(BuildContext context) async {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          // Confirm delete button
          TextButton(
            onPressed: () async {
              // Call the delete API to remove the user from the database
              final response = await http.delete(
                Uri.parse('http://10.0.2.2:3000/delete/$userId'), // Replace with your actual API endpoint
              );

              if (response.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('User deleted successfully'),
                  backgroundColor: Colors.green,
                ));
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the login screen
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to delete user'),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Text('Yes, Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal, // Match app bar color with login/register screens
        elevation: 4,
      ),
      backgroundColor: Colors.grey[100], // Light background color for consistency
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center-align the text
            children: [
              // Welcome message inside a border
              Text(
                'Welcome to Biomark!',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              SizedBox(height: 16),
              // Email inside the same container
              Text(
                'Email: $email',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              // User ID inside the same container
              Text(
                'User ID: $userId',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24), // Space below the user details

              // Grid of buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // 2 columns for a 2x2 grid
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Pass userId and email to UpdateInfoScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateInfoScreen(
                              userId: userId,  // Pass userId
                              email: email,     // Pass email
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.update),
                      label: Text('Update Info'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to ViewInfoScreen and pass userId and email
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewInfoScreen(
                              userId: userId,  // Pass userId
                              email: email,     // Pass email
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.visibility),
                      label: Text('View Info'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Delete Info action
                        _deleteUser(context); // Show confirmation dialog
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Delete Info'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to AboutScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(), // Navigate to AboutScreen
                          ),
                        );
                      },
                      icon: Icon(Icons.info),
                      label: Text('About'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Logout Button at the Bottom with Icon
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Go back to login screen
                  },
                  icon: Icon(Icons.logout, color: Colors.white), // Logout icon
                  label: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
