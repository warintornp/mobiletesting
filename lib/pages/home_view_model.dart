import 'package:flutter/material.dart';
import 'package:mobiletesting/user_service.dart';

class HomeViewModel extends ChangeNotifier {
  final UserService userService;
  Map<String, dynamic> _userDetails = {};

  HomeViewModel({required this.userService});
  Map<String, dynamic> get userDetails => _userDetails;

  Future<void> onDidLoad() async {
    _userDetails = await userService.fetchUserDetails();
    notifyListeners();
  }
}
