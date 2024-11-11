import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Biomark'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'About Biomark',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Biomark is a research organization that collects large quantities of personal information from adult volunteers. This information is used to build predictive machine learning models that help personalize digital services. The data provided by participants is kept confidential and used only for future analysis in model building.\n\n'
                    'Volunteers who participate in Biomark\'s research are granted a Participator Account (PAC), which may entitle them to special benefits when useful models are built in the future. The data collected is anonymized to ensure the privacy of the volunteers.\n\n'
                    'By volunteering, individuals contribute to creating models that aim to improve personalized services in various fields, making them more efficient and tailored to the needs of users.',
                style: TextStyle(fontSize: 18, color: Colors.teal[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
