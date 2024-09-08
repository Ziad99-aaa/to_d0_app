import 'package:flutter/material.dart';
import 'package:to_d0_app/User.dart';

class UserProvider extends ChangeNotifier {
  Userr? currentUser;

  void ChangeUser(Userr newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
