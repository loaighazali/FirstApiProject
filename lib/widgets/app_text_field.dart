import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

   AppTextField({
     required this.hint,
     required this.perfixIcon,
     required this.controller,
     this.textInputType = TextInputType.text,
     this.obscur = false,
    } );

  final String hint;

  final IconData perfixIcon;

  final TextInputType textInputType;

  final bool obscur;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller,
      keyboardType:textInputType,
      obscureText:obscur,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(perfixIcon),
        prefixIconColor: Colors.cyan,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
              color: Colors.cyan,
          ),
        ),
      ),
    );
  }


}
