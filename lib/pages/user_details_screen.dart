import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userDetails;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${userDetails['name'] ?? 'N/A'}'),
            Text('Email: ${userDetails['email'] ?? 'N/A'}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
