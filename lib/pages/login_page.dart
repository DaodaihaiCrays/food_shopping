import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/forgot_password_page.dart';
import 'package:e_commerce/pages/signup_page.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/share_pref.dart';
import 'package:e_commerce/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bottom_nav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );

      var currentUser = await DatabaseMethods().getUserByEmail(email);


      String name = currentUser?["Name"]; 
      String wallet = currentUser?["Wallet"]; 
      String id = currentUser!.id;

      // Lưu vào SharedPreferences
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserEmail(email);
      await SharedPreferenceHelper().saveUserName(name);
      await SharedPreferenceHelper().saveUserWallet(wallet);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Text(""),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 13,
              ),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "images/logo_app2.png",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 2.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text("Login", style: AppWidget.headlineTextStye()),
                            TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Email";
                                }
                                if (!RegExp(
                                  r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+",
                                ).hasMatch(value)) {
                                  return "Please Enter Valid Email";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: AppWidget.samiBoolTextStye(),
                                suffixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Password";
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: AppWidget.samiBoolTextStye(),
                                suffixIcon: Icon(Icons.password_outlined),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Forgot Password ?",
                                  style: AppWidget.samiBoolTextStye(),
                                ),
                              ),
                            ),
                            SizedBox(height: 80),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 6,
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFFff5c30),
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  email = emailcontroller.text;
                                  password = passwordcontroller.text;
                                }
                                userLogin();
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Signup",
                      style: AppWidget.samiBoolTextStye(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
