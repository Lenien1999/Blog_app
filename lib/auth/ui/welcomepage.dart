// ignore_for_file: non_constant_identifier_names

import 'package:blog_app/blog_category/Backend/latestbackend/latestmodel.dart';
import 'package:blog_app/blog_category/latest/latestnews.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blog_category/latest/addlatest.dart';
import '../../blog_category/news/news.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

// ignore: duplicate_ignore
class _WelcomePageState extends State<WelcomePage> {
  DateTime date = DateTime.now();
  final mydate = DateFormat.yMEd();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (__) {
                return const AddLatest();
              }));
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          appBar: AppBar(
            toolbarHeight: 70,
             backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
             
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        color:Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu,
                        color: Colors.white))
              )
            ],
            leading: const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text("A")),
            ),
            bottom: const TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.redAccent,
              unselectedLabelColor: Color.fromARGB(255, 163, 18, 120),
              tabs: [
                Tab(
                    child: Text(
                  'For you',
                  style: TextStyle(),
                )),
                Tab(
                    child: Text(
                  'News',
                  style: TextStyle(),
                )),
                Tab(
                    child: Text(
                  'Top Story',
                  style: TextStyle(),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  BuildTopBar(textleft: "$date", text: "Latest News"),
                  CarouselSlider(
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      items: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/office.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(9)),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ),
                            const Positioned(
                              top: 15,
                              left: 10,
                              right: 5,
                              child: Text(
                                  "Nigeria will be Great say President Muhammed Buhari",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  )),
                            )
                          ],
                        ),
                        Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/security.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(9)),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ),
                            const Positioned(
                              top: 15,
                              left: 10,
                              right: 5,
                              child: Text(
                                  "Nigeria will be Great say President Muhammed Buhari",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  )),
                            )
                          ],
                        ),
                      ]),
                      BuildTopBar(textleft: "See All", text: "Popular Topics"),
                  BuildLatestNews(),
                ],
              ),
              const BuildNews(),
              const Icon(Icons.directions_car, size: 350),
            ],
          ),
        ),
      ),
    );
  }

  BuildLatestNews() {
    return StreamBuilder<List<LatestModel>>(
        stream: readLatest(),
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
                        return LatestNews(latest: latest);
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

  Stream<List<LatestModel>> readLatest() => FirebaseFirestore.instance
      .collection('Popular')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => LatestModel.fromJson(doc.data()))
          .toList());

  Padding BuildTopBar({
    required String text,
    required String textleft,
  }) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 19,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 111, 111),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            textleft,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}
