

// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
 
class Users {

  
    int ?id;
    String? username;
    String ?password;
    String ?fullname;
    Users({
        this.id,
        this.username,
        this.password,
        this.fullname,
    });


    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        fullname: json["fullname"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "password": password,
        "username": username,
    };
}
