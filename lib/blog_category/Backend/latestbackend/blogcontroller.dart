import 'package:blog_app/blog_category/Backend/latestbackend/blogmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BlogController {


  Future insertBlog(BlogModel latest, BuildContext context) async {
    CollectionReference blog =
        FirebaseFirestore.instance.collection('${latest.feature}') ;
           return blog.doc(blog.id).set(
          latest.toJson())
          .then((value) => Navigator.pop(context))
          .catchError((error) => registerToast("Failed to add ${latest.feature} : $error"));
    
  }

  Future<void> deleteBlog() {
    CollectionReference blog =
        FirebaseFirestore.instance.collection('Popular');
    return blog
        .doc(blog.id)
        .delete()
        .then((value) => registerToast("Blog Deleted"))
        .catchError((error) => registerToast("Failed to delete Blog: $error"));
  }

  Future<void> updateBlog(BlogModel latest, BuildContext context) {
    CollectionReference blog =
        FirebaseFirestore.instance.collection('Popular');
    return blog
        .doc(blog.id)
        .update(latest.toJson()
          
        )
        .then((value) => registerToast("Blog Deleted"))
        .catchError((error) => registerToast("Failed to delete Blog: $error"));
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
