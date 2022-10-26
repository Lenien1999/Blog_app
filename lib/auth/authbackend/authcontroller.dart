// ignore_for_file: deprecated_member_use

import 'package:blog_app/auth/authbackend/authmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bottomnavigation.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future register(Users users) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: "${users.username}",
        password: "${users.password}",
      );
      User? user = result.user;
      user?.updateProfile(displayName: users.fullname); //added this line
      return user;
    } catch (e) {
      registerToast(e.toString());
    }
  }

  Future login(Users users, BuildContext context) async {
    try {
return await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "${users.username}",
    password: "${users.password}"
  ).then((value) =>   route(context));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        registerToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        registerToast('Wrong password provided for that user.');
      }
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor:
            toast == "Register sucessfull" ? Colors.green : Colors.red,
        textColor: Color.fromARGB(255, 202, 193, 193));
  }
   void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Admin") {
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  BuildBottomNavigation()
          ),
        );
        }else{
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BuildBottomNavigation()
          ),
        );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

}
