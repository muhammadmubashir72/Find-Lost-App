// ignore_for_file: prefer_const_constructors, file_names, deprecated_member_use, use_build_context_synchronously, avoid_print, non_constant_identifier_names, unused_import, unused_field

import 'package:flutter/material.dart';

import '../widget/widget.dart';
import 'loginScreen.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(onPressed: (){
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }, icon: Icon(Icons.chevron_left),color: Colors.black, ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --------------Email Field----------------
                    Padding(
                      padding: const EdgeInsets.only(top:70),
                      child: Center(
                        child: Image.asset("assets/images/logo.png",
                          width: 120,
                          height: 120,),
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "Please, enter your email address. You will receive a link to create a new password via email.",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 10),

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
                          return 'Not a valid email address. Should be your@email.com';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Center(
                      child: RoundedButton(
                          child:Text("Send",
                              style: Theme.of(context).textTheme.displaySmall),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                emailController.text = "";
                              });

                            } else {
                              setState(() {
                              });
                            }
                          }),
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
}