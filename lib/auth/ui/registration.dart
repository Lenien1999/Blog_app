import 'package:blog_app/auth/authbackend/authcontroller.dart';
import 'package:blog_app/auth/authbackend/authmodel.dart';
import 'package:blog_app/auth/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'contant/inputfield.dart';
import 'contant/roundedbutton.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final username = TextEditingController();
  final fullname = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text("Create Account"),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                child: RoundedInputField(
                    hintText: 'Username',
                    controller: username,
                    icon: Icons.person),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                child: RoundedInputField(
                    hintText: 'Full Name',
                    controller: fullname,
                    icon: Icons.person),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                  child: RoundedInputField(
                      hintText: 'Password',
                      controller: password,
                      icon: Icons.password_rounded)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                  child: RoundedInputField(
                      hintText: 'Confirm Password',
                      controller: confirmpassword,
                      icon: Icons.password_rounded)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                child: RoundedButton(
                    text: 'Submit',
                    press: () {
                      if (password.text.isNotEmpty &&
                          username.text.isNotEmpty) {
                        final details = Users(
                          username: username.text,
                          password: password.text,
                          fullname: fullname.text,
                        );
                        
                        authController.register(details).catchError((error) {
         
        registerToast(error);
      });
                        
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const Login()));
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor:
            toast == "Register sucessfull" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }
}
