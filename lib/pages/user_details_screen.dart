import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final String userDetails;

  UserDetailsScreen({required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userDetails}')
            // Text('Name: ${userDetails['name']}', style: TextStyle(fontSize: 18)),
            // SizedBox(height: 10),
            // Text('Email: ${userDetails['email']}', style: TextStyle(fontSize: 18)),
            // Add more details if needed
          ],
        ),
      ),
    );
  }
}
