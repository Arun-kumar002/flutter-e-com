import "package:flutter/material.dart";
import "package:e_com/feature/auth/screens/auth_screen.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    default:
      print("Screen not found ===>[${routeSettings.name}]<======");
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen does not exists..."),
                ),
              ));
  }
}
