// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RoundedButton extends StatelessWidget {
  Widget child;
  VoidCallback onPressed;
  EdgeInsetsGeometry? margin;
  RoundedButton({required this.child, required this.onPressed, this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: margin,
        width: 340,
        height: 58,
        decoration: const BoxDecoration(
            color: Color(0xffb80924),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Center(child: child),
      ),
    );
  }
}
//Every place use this TextField
class GetTextField extends StatelessWidget {
  TextEditingController? controller;
  int? maxlines;
  String labelText;
  String hintText;
  Widget prefixIcon;
  Widget? suffiixIcon;
  bool isObscureText;
  TextInputType keyboardType;
  void Function(String)? onChanged;
  void Function()? onEditingComplete;
  void Function()? onTap;
  String? Function(String?)? validator;
  ToolbarOptions? toolbarOptions;

  GetTextField(
      {this.controller,
        this.maxlines,

        required this.hintText,
      required this.prefixIcon,
      this.suffiixIcon,
      this.isObscureText = false,
      required this.keyboardType,
      this.onChanged,
        this.onEditingComplete,
        this.onTap,
      this.validator,
      this.toolbarOptions,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      onEditingComplete: onEditingComplete,
      toolbarOptions: toolbarOptions,
      cursorHeight: 17,
      cursorColor: Color.fromARGB(255, 47, 22, 22),
      keyboardType: TextInputType.name,
      controller: controller,
      style: Theme.of(context).textTheme.labelMedium,
      autofocus: false,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      obscureText: isObscureText,
      decoration: InputDecoration(
          suffixIcon: suffiixIcon,
          prefixIcon: prefixIcon,
          fillColor: Color.fromARGB(79, 239, 239, 239),
          filled: true,
          contentPadding: EdgeInsets.all(25),
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36))),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36) )),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36) )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36)))),

    );
  }
}

//Only Bottom place use this TextField
class RoundedButtons extends StatelessWidget {
  Widget child;
  VoidCallback onPressed;
  EdgeInsetsGeometry? margin;
  RoundedButtons({required this.child, required this.onPressed, this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: margin,
        width: 340,
        height: 58,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Center(child: child),
      ),
    );
  }
}

class GetTextFormField extends StatelessWidget {
  TextEditingController? controller;
  int? maxlines;
  String labelText;
  String hintText;
  Widget? prefixIcon;
  Widget? suffiixIcon;
  bool isObscureText;
  TextInputType keyboardType;
  void Function(String)? onChanged;
  void Function()? onEditingComplete;
  void Function()? onTap;
  String? Function(String?)? validator;
  ToolbarOptions? toolbarOptions;

  GetTextFormField(
      {this.controller,
        this.maxlines,
        required this.hintText,
        this.prefixIcon,
        this.suffiixIcon,
        this.isObscureText = false,
        required this.keyboardType,
        this.onChanged,
        this.onEditingComplete,
        this.onTap,
        this.validator,
        this.toolbarOptions,
        required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      onEditingComplete: onEditingComplete,
      toolbarOptions: toolbarOptions,
      cursorHeight: 17,
      cursorColor: Color.fromARGB(255, 47, 22, 22),
      keyboardType: TextInputType.name,
      controller: controller,
      style: Theme.of(context).textTheme.displayMedium,
      autofocus: false,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      obscureText: isObscureText,
      decoration: InputDecoration(
          suffixIcon: suffiixIcon,
          prefixIcon: prefixIcon,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.all(25),
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36))),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36) )),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36) )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2A2C36)))),

    );
  }
}

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      webBgColor: "green",
      webPosition: "center",
      fontSize: 16.0);
}