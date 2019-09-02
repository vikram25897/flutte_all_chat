import 'package:flutter/material.dart';

class SimpleInputField extends StatelessWidget{
  final String Function(String) validator;
  final Function(String) onSubmit;
  final TextEditingController controller;
  final String label;
  const SimpleInputField({this.validator, this.onSubmit, this.controller, this.label});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onFieldSubmitted: onSubmit,
      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
      autovalidate: true,
      autocorrect: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
      ),
    );
  }
}