// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_field, file_names, annotate_overrides, avoid_print, non_constant_identifier_names, unused_import, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/widget.dart';
import 'firebase_auth_service.dart';
import 'homescreen.dart';
import 'landingScreen.dart';
import 'loginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthService _authService = FirebaseAuthService();

  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  bool _isSignup = false;
  bool _obscureText = true;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:70),
                child: Image.asset("assets/images/logo.png",
                  width: 120,
                height: 120,),
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //-----------------Name Field-----------------
                    GetTextField(
                      maxlines: 1,
                      controller: nameController,
                      labelText: "Name",
                      hintText: "Enter your Name",
                      prefixIcon: Icon(Icons.person),
                      keyboardType: TextInputType.name,
                      toolbarOptions: ToolbarOptions(
                          copy: true, cut: true, paste: true, selectAll: true),
                      onChanged: (Value) {
                        setState(() {
                          _userName = Value;
                        });
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_nameFocus);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }

                        // Return null if the entered username is valid
                        return null;
                      },
                    ),

                    SizedBox(height: 10),

                    //-----------------Email Field-----------------

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
                      suffiixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: _toggle,
                      ),
                      onChanged: (Value) {
                        setState(() {
                          _userPassword = Value;
                        });
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
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
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                        child: _isSignup
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.lightGreenAccent,
                              )
                            : Text("Sign Up",
                                style: Theme.of(context).textTheme.displaySmall),

                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                             SignUp();
                              _formKey.currentState!.reset();
                              nameController.clear();
                             emailController.clear();
                             passwordController.clear();


                            });
                          }
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
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
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headlineSmall,
                      )),
                  Icon(Icons.arrow_right_alt, color: Color(0xffEF3651)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void SignUp() async {
    setState(() {
      _isSignup = true;
    });

    _userName = nameController.text;
    _userEmail = emailController.text;
    _userPassword = passwordController.text;

    User? user = await _authService.signUpWithEmailAndPassword(
        _userEmail, _userPassword);

    setState(() {
      _isSignup = false;
    });
    if (user != null) {
      showToast(message: "User is successfully created");
      // print("User is successfully created");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      showToast(message: "Some error occurred!");
      // print("Some error occurred!");
    }
  }
}
