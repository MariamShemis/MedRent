import 'package:flutter/material.dart';

class PinField extends StatelessWidget {
  const PinField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium,
        decoration: InputDecoration(
          fillColor: Color(0xFFFFFFFF),
          filled: true,
          contentPadding: EdgeInsets.zero,
          counterText: '',
          helperStyle: TextStyle(height: 0 , fontSize: 0),
          errorStyle: TextStyle(height: 0 , fontSize: 0),
      
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Color(0xFF575655) , width: 2)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Color(0xFF031B4E) , width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
          if (value.isEmpty ) {
             FocusScope.of(context).previousFocus();
          }
        },
        maxLength: 1, 
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ''; 
          }
          return null;
        
        },

      ),
    );
  }
}
