

import 'package:blog_app/blog_category/news/readnews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Backend/latestbackend/latestmodel.dart';

class BuildNews extends StatefulWidget {
  const BuildNews({Key? key}) : super(key: key);

  @override
  State<BuildNews> createState() => _BuildNewsState();
}

class _BuildNewsState extends State<BuildNews> {
  @override
  Widget build(BuildContext context) {
       return StreamBuilder<List<LatestModel>>(
        stream: readNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong ${snapshot.error}");
          } else if (snapshot.hasData) {
            return Column(
                children: snapshot.data!.map<Widget>(
              (latest) {
                
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ReadNews(latest: latest);
                      }));
                    },
                    child: Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 210, 210),
                          borderRadius: BorderRadius.circular(19)),
                      child: Row(children: [
                        Container(
                          margin:
                              const EdgeInsets.only(left: 10, top: 7, bottom: 7),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/security.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(9)),

                          width: 100,
                          // child: Image.asset("name")
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    "${latest.title}",
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${latest.headline}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("By Dr. Aminu"),
                                      Text("${latest.date}")
                                    ],
                                  )
                                ]),
                          ),
                        )
                      ]),
                    ),
                  )),
                );
              },
            ).toList());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
 
 
    
  }
    Stream<List<LatestModel>> readNews() => FirebaseFirestore.instance
      .collection('News')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => LatestModel.fromJson(doc.data()))
          .toList());

}