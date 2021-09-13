import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // const CustomTextField({Key? key}) : super(key: key);
  String label;
  TextEditingController controller;
  bool isObscure;

  CustomTextField(this.label, this.controller,{this.isObscure=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        obscureText: this.isObscure,
        controller: this.controller,
        decoration: InputDecoration(
          labelText: this.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
