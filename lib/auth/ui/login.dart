// ignore_for_file: prefer_const_constructors

import 'package:blog_app/auth/ui/contant/roundedbutton.dart';
import 'package:blog_app/auth/ui/registration.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottomnavigation.dart';
import '../authbackend/authcontroller.dart';
import '../authbackend/authmodel.dart';
import 'contant/inputfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  AuthController authController = AuthController();
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: Center(
          child: ListView(
            
            shrinkWrap: true, children: [
              Image.asset('assets/images/blog.jpg', ),
            // const CircleAvatar(
            //     radius: 70,
            //     backgroundColor: Color.fromARGB(255, 175, 18, 18),
            //     child: Icon(Icons.person_outlined, size: 60)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
              child: RoundedInputField(
                  hintText: 'Username',
                  controller: username,
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
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
              child: RoundedButton(
                  text: 'Submit',
                  press: () {
                    final details = Users(
                      username: username.text,
                      password: password.text,
                    );

                    if (username.text.isEmpty) {
                      registerToast("Please Enter User Email");
                    } else if (password.text.isEmpty) {
                      registerToast("Please Enter Password");
                    } else {
                      authController.login(details).then((value) {
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (__) {
                          return BuildBottomNavigation();
                        }));
                      });
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Registration();
                      }));
                    },
                    child: Text(
                      'Create New Account?',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
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

  Future setSP(Users user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", "${user.id}");
    sp.setString("fullname", user.fullname ?? "");
    sp.setString("email", user.username ?? "");
    sp.setString("password", user.password ?? "");
  }
}
