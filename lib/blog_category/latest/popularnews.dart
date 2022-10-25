// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import '../Backend/latestbackend/blogmodel.dart';

class PopularNews extends StatelessWidget {
  final BlogModel popular;
  // ignore: use_key_in_widget_constructors
  const PopularNews({required this.popular,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(popular.title.toString()),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.favorite, color: Colors.white))
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "${popular.headline}",
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            Positioned.fill(
              top: 70,
              child: SingleChildScrollView(
                  child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/images/security.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("${popular.content }",
                    maxLines: 80,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        wordSpacing: 2,
                        fontSize: 18,
                        color: Color.fromARGB(255, 110, 96, 96)),
                  ),
                )
              ])),
            ),
            Positioned(
              bottom: 0,
              left: 5,
              right: 5,
              child: SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                            decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 3, color: Colors.redAccent),
                          ),
                          prefixIcon: Icon(
                            Icons.comment,
                            color: Colors.redAccent,
                          ),
                          hintText: 'Add a comment ',
                          hintStyle: TextStyle(color: Colors.redAccent),
                          hintTextDirection: TextDirection.ltr,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.redAccent),
                          ),
                        )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green)),
                              height: 60,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.share, color: Colors.green)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.deepPurple)),
                              height: 60,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.thumb_up,
                                      color: Colors.deepPurple)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.green)),
                              height: 60,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications,
                                      color: Colors.green)),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  
  
  }
}
