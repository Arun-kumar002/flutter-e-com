import 'package:e_com/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  User _user = User(
      id: "",
      name: "",
      password: "",
      address: "",
      type: "",
      token: "",
      email: "");

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
