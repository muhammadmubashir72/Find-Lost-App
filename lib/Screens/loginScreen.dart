// ignore_for_file: prefer_const_constructors, file_names, deprecated_member_use, use_build_context_synchronously, avoid_print, non_constant_identifier_names, unused_import, unused_field

import 'package:find_lost_app/Screens/signupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/widget.dart';
import 'firebase_auth_service.dart';
import 'forgotScreen.dart';
import 'homescreen.dart';
import 'landingScreen.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  String _userEmail = '';
  String _userPassword = '';
  bool _isLogin = false;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                // --------------Email Field----------------
                    Padding(
                      padding: const EdgeInsets.only(top:70),
                      child: Image.asset("assets/images/logo.png",
                        width: 120,
                      height: 120,),
                    ),
                    GetTextField(
                      maxlines: 1,
                      controller: emailController,
                      labelText: "Email",
                      hintText: "Please input verify email",
                      prefixIcon: Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      toolbarOptions: ToolbarOptions(
                          copy: true, cut: true, paste: true, selectAll: true),
                      onChanged: (Value) {
                        setState(() {
                          _userEmail = Value;
                        });
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    //-----------------Password Field-----------------

                    GetTextField(
                      maxlines: 1,
                      controller: passwordController,
                      labelText: "Password",
                      hintText:
                          "One Word Capital, Small & Number",
                      prefixIcon: Icon(Icons.lock),
                      keyboardType: TextInputType.text,
                      isObscureText: _obscureText,
                      onChanged: (Value) {
                        setState(() {
                          _userPassword = Value;
                        });
                      },
                      suffiixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _toggle();
                            });
                          }),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        }
                        // r'^ -> (?=.*[A-Z])   should contain at least one upper case
                        //  (?=.*[a-z])        should contain at least one lower case
                        //  (?=.*?[0-9])       should contain at least one digit
                        //  (?=.*?[!@#\$&*~])  should contain at least one Special character
                        //  .{8,}              Must be at least 8 characters in length  $
                        // Return null if the entered password is valid
                        return null;
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotScreen()));
                            },
                            child: Text(
                              "Forgot your password?",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        Icon(Icons.arrow_right_alt, color: Color(0xffEF3651)),
                      ],
                    ),

                    RoundedButton(
                        child: _isLogin
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.lightGreenAccent,
                              )
                            : Text("Log In",
                            style: Theme.of(context).textTheme.displaySmall),
                        onPressed: () {
                            if (_formKey.currentState!.validate()) {
                            setState(() {
                              SignIn();
                              _formKey.currentState?.reset();
                              emailController.clear();
                              passwordController.clear();
                            });

                          } else {
                            setState(() {
                            });
                          }
                        }),

                    SizedBox(height: 20),

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.headlineSmall,
                          )),
                      Icon(Icons.arrow_right_alt, color: Color(0xffEF3651)),
                    ]),
                    SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/google.png",
                          width: 50,height: 50,),),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/facebook.png"
                          ,width: 50,height: 50,)),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/twitter.png",
                            width: 50,height: 50,
                          ))
                    ]),
                    SizedBox(height: 10),
                    Text(
                      "SIGN IN WITH",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void SignIn() async {
    setState(() {
      _isLogin = true;
    });
    _userEmail = emailController.text;
    _userPassword = passwordController.text;

    User? user = await _authService.signInWithEmailAndPassword(
        _userEmail, _userPassword);
    setState(() {
      _isLogin = false;
    });
    if (user != null) {
      showToast(message: "User is successfully created");
      print("User is successfully created");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showToast(message: "Some error occurred!");
      print("Some error occurred!");
    }
  }
}
