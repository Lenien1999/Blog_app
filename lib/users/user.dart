import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
     final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      appBar:AppBar(
        title: const Text("Users"),
        centerTitle:true,
        backgroundColor:Colors.redAccent,
      ),
      body:StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              // title: Text(data['username']),
              // subtitle: Text(data['email']),
            );
          }).toList(),
        );
      },
    ));
    
  }
}