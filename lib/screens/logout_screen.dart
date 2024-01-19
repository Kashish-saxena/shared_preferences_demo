import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserData extends StatefulWidget {
  const LoginUserData({super.key});

  @override
  State<LoginUserData> createState() => _LoginUserDataState();
}

class _LoginUserDataState extends State<LoginUserData> {
  late SharedPreferences data;
  removeValues() async {
    data = await SharedPreferences.getInstance();
    data.clear();
    log("Inside remove>>>>>>>>>>>>>>");
  }

  Future<String> getEmailValues() async {
    data = await SharedPreferences.getInstance();
    String email = data.getString('email') ?? "";
    return email;
  }

  init() async {
    email = await getEmailValues();
    setState(() {});
    log("Email in  logout screen $email");
  }

  String? email;
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Successmark.png"),
            const Text(
              "Logged In",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "User Email:$email",
              style: const TextStyle(fontSize: 18),
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
              onPressed: () {
                removeValues();

                Navigator.pop(context);
              },
              child: const Text("Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
