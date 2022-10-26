// ignore_for_file: prefer_const_constructors

import 'package:blog_app/auth/authbackend/authcontroller.dart';
import 'package:blog_app/auth/authbackend/authmodel.dart';
import 'package:blog_app/auth/ui/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String selectedrole = "user";
List<String> role = ["user","Admin"];
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
              Myinputfield(
                  widget: DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down, color:Colors.white
                      ),
                      iconSize: 32,
                      elevation: 4,
                      onChanged: (String? newvalue) {
                        setState(() {
                         selectedrole  = newvalue!;
                        });
                      },
                      underline: Container(height: 0),
                      items: role
                          .map<DropdownMenuItem<String>>(
                              (String e) => DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  )))
                          .toList()),
                   
                  hint: "$selectedrole   "),
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

                        authController.register(details).then((value) =>
                            postDetailsToFirestore(username.text, selectedrole ));
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

  postDetailsToFirestore(String email, String role) async {
    final _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': email, 'role': role});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  // ignore: non_constant_identifier_names
  Myinputfield(
      {
      required String hint,
      bool? content,
      TextEditingController? controller,
      Widget? widget}) {
         Size size = MediaQuery.of(context).size;
    return Container(
   padding:  const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       
        Container(
         margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
       height: 60,
      decoration: BoxDecoration(
        color:Color.fromARGB(255, 102, 95, 95),
        borderRadius: BorderRadius.circular(29),
      ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.newline,
                 
                  maxLines: null,
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  controller: controller,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    color: Color.fromARGB(255, 54, 51, 51),
                  )),
                  decoration: InputDecoration(
                    prefixIcon:Icon(Icons.person,color:Colors.white ),
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Color.fromARGB(255, 54, 51, 51),
                    hintText: hint,
                      hintStyle: const TextStyle(
              color:Colors.white,
              fontSize: 20,
              
            ),
             
            border: InputBorder.none,
                    
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        )
      ]),
    );
  }
}
