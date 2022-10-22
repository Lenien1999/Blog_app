import 'package:blog_app/blog_category/Backend/latestbackend/latestmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LatestController {


  Future insertlatest(LatestModel latest, BuildContext context) async {
    CollectionReference latests =
        FirebaseFirestore.instance.collection('${latest.feature}') ;
           return latests
          .add(latest.toJson())
          .then((value) => Navigator.pop(context))
          .catchError((error) => registerToast("Failed to add ${latest.feature} : $error"));
    
  }


  // Future Querylatest() async {
  //   List<LatestModel> latestlist = [];
  //   LatestModel latest=LatestModel();
  //   var latests =
  //       FirebaseFirestore.instance.collection('${latest.feature}').get() ;
  //   for (var element in latests){
  //     var latestinfo = LatestModel.fromJson(element);
  //     latestlist.add(latestinfo);
  //   }

  //   return latestlist;
    
  // }
    

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
