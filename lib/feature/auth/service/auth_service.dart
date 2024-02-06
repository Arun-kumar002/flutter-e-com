import 'dart:convert';

import 'package:e_com/constant/error_handling.dart';
import 'package:e_com/constant/global_variable.dart';
import 'package:e_com/constant/utils.dart';
import 'package:e_com/feature/home/screen/home_screen.dart';
import 'package:e_com/model/user.dart';
import 'package:e_com/provider/user_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    User user = User(
        id: "",
        name: name,
        password: password,
        address: "",
        type: "",
        token: "",
        email: email);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/users/signup"),
          body: user.toJson(),
          headers: <String, String>{"Content-Type": "application/json"});
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context: context, text: "Account created.");
          });
    } catch (e) {
      print("Error:[AuthService.signUpUser]: $e");
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    User user = User(
        id: "",
        name: "",
        password: password,
        address: "",
        type: "",
        token: "",
        email: email);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/users/login"),
          body: user.toJson(),
          headers: <String, String>{"Content-Type": "application/json"});
      // ignore: use_build_context_synchronously
      print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)["token"]);

            showSnackBar(context: context, text: "login successful.");

            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      print("Error:[AuthService.signUpUser]: $e");
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, text: e.toString());
    }
  }
}

//http | shared_preferences | provider