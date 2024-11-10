import 'package:flutter/material.dart';
import 'package:mobiletesting/home_screen/user_tier.dart';

class UserProfileView extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  const UserProfileView({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    final tier = UserTierExtension.fromString(userDetails['tier'] ?? '');

    return Stack(
      key: Key("user_profile"),
      children: [
        Container(
          height: 100,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tier.color, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // User Name
              Text(
                userDetails['name'] ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // User Email
              Text(
                userDetails['email'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
