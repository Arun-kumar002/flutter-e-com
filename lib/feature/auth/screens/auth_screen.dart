import 'package:e_com/common/widgets/custom_button.dart';
import 'package:e_com/common/widgets/custom_text_field.dart';
import 'package:e_com/constant/global_variable.dart';
import 'package:e_com/feature/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = "/auth-screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              // textColor: _auth == Auth.signup
              //     ? GlobalVariables.backgroundColor
              //     : GlobalVariables.greyBackgroundColor,
              title: const Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (val) => {
                  setState(() => {_auth = val!})
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: signUpFormKey,
                  child: Column(children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: "Signup",
                        onTap: () {
                          if (signUpFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                        })
                  ]),
                ),
              ),
            ListTile(
              title: const Text(
                "Sign in ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (val) => {
                  // ignore: unnecessary_set_literal
                  setState(() => {_auth = val!})
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: signInFormKey,
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: "Signin",
                        onTap: () {
                          if (signInFormKey.currentState!.validate()) {
                            signInUser();
                          }
                        })
                  ]),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
