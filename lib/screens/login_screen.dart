import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_demo/screens/logout_screen.dart';
import 'package:shared_preferences_demo/utils/signup_verification.dart';
import 'package:shared_preferences_demo/widgets/link_buttons.dart';
import 'package:shared_preferences_demo/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences data;
  setEmailValues(String email) async {
    data = await SharedPreferences.getInstance();
    data.setString('email', email);
    log(email);
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
            // leading: BackButtonWidget(
            //     onTap: () => Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => const WelcomeScreen()))),
            ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: _loginKey,
                child: Column(
                  children: [
                    const Text(
                      "Welcome back! Glad to see you, Again!",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldWidget(
                      validator: (val) {
                        return Verification.isEmailValid(val);
                      },
                      obscureText: false,
                      controller: emailController,
                      text: "Enter your email",
                    ),
                    TextFormFieldWidget(
                      validator: (val) {
                        return Verification.isPasswordValid(val);
                      },
                      obscureText: false,
                      controller: passwordController,
                      text: "Enter your password",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(370, 60),
                        backgroundColor: const Color(0xff1E232C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        if (_loginKey.currentState!.validate()) {
                          await setEmailValues(emailController.text);

                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginUserData()));
                          }
                        }
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Or Login With',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const LinkButtonWidget(),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xff032426)),
                        ),
                        InkWell(
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          onTap: () {
                            // String email = await getEmailValues();
                            // log(email);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
