import "dart:convert";
import "package:e_com/constant/utils.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void httpErrorHandle(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
          context: context, text: jsonDecode(response.body)["message"]);
      break;
    default:
      showSnackBar(context: context, text: response.body);
  }
}