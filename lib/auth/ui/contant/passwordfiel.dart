
import 'package:flutter/material.dart';

 
import 'inputfield.dart';
 

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const RoundedPasswordField({
    Key? key,
    required this.controller,
    this.validate,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    bool isvisible = false;
    return TextFieldContainer(
      child: TextFormField(
        
        validator: widget.validate,
        controller: widget.controller,
        obscureText: isvisible,
        cursorColor: const Color(0xFF282B30),
        decoration: const InputDecoration(
          contentPadding:EdgeInsets.only(top:20),
          hintText: "Password",
         
           
          border: InputBorder.none,
        ),
      ),
    );
  }
}
