// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

 

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validate;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.validate,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key=GlobalKey<FormFieldState>();
    return TextFieldContainer(
      child: Form(
        key:key,
        child: TextFormField(
          
          validator: validate,
          
          controller: controller,
          cursorColor:  Colors.redAccent,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.all(18),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color:Colors.white,
              fontSize: 20,
              
            ),
             
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}


 
 
class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
       height: 60,
      decoration: BoxDecoration(
        color:Color.fromARGB(255, 102, 95, 95),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
