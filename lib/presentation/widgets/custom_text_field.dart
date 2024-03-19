
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final String label;
  final bool submitted;
  final TextEditingController controller;

  const CustomTextField({
    super.key,

    required this.hintText,
    required this.submitted,
    required this.label, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: const Color.fromARGB(255, 238, 238, 238),
      child: TextFormField(
        controller: controller, 
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (submitted && (value == null || value.isEmpty)) {
            return '$hintText is required';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
        
          label: Text(label,style: TextStyle(color: Colors.white,letterSpacing: 0.8,fontSize: 20),),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
