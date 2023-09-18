import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    required this.controller,
    required this.focusNode,
    required this.onChange,
    super.key,
  });

  final TextEditingController controller ;
  final FocusNode focusNode ;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode:focusNode ,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      onChanged: onChange,
      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          counterText: '',
          enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(color: Colors.cyan)
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({ Color color = Colors.grey}) {
    return OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: color,
            )
        );
  }
}
