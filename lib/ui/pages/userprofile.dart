import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibeus/models/user.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/EditProfile.dart';
import 'package:vibeus/ui/pages/addposts.dart';
import 'package:vibeus/ui/pages/settings.dart';
import 'package:vibeus/ui/widgets/postwidget.dart';

final userData = Firestore.instance.collection("user");
CollectionReference collectionReference =
    Firestore.instance.collection('users');

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  UserRepository userRepository;

  final String userId;
  final User user;

  UserProfile({this.userId, this.userRepository, this.user});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String currentUserUid;

  List postList = [];

  bool loading = false;

  createprofile() {
    bool ownProfile = currentUserUid == widget.userId;
    if (ownProfile) {
      return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Addposts(
                                user: widget.user,
                                userId: widget.userId,
                              )));
                },
                child: Icon(Icons.add_box_outlined)),
            elevation: 0,
            backgroundColor: backgroundColor,
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProile(
                              userId: widget.userId,
                            )));
              }),
          body: ownerProfilescreen());
    } else {
      return userporfilescreen();
    }
  }

  createProfileButton(onPressed, text) {
    return RaisedButton(
      child: Text(text),
      onPressed: onPressed,
      color: Colors.red,
    );
  }

  getCurrentUserId() async {
    String onwnerprofileId = await widget.userRepository.getUser();
    setState(() {
      currentUserUid = onwnerprofileId;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllProfilePost();

    getCurrentUserId();

    print(currentUserUid);
    print(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = Firestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.document(widget.userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: createprofile(),
          );
        }

        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.black,
        ));
      },
    );
  }

  Widget ownerProfilescreen() {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = Firestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.document(widget.userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data;

            return SingleChildScrollView(
              child: Container(
                color: backgroundColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${data['photoUrl']}"),
                        ),
                      ),
                    ),
                    // Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " ${data['name']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Linkify(
                              onOpen: (link) async {
                                await launch(link.url);
                                print(link);
                              },
                              text: """
${data['bio']}""",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              linkStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Divider(),
                    displayProfilePost(),
                  ],
                ),
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ));
        });
  }

  Widget profilePostView() {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('UsersPosts')
            .document(widget.userId)
            .collection('UsersPosts')
            .where("postuserId", isEqualTo: widget.userId)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null ||
              snapshot.data.documents.length == 0 ||
              snapshot == null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      child: Icon(
                        MdiIcons.cameraOutline,
                        color: Colors.black,
                        size: 60,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No Vibe Yet",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),
            );
          } else {
            return Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (contesxt, index) {
                    return GestureDetector(
                      onTap: () {
                        print("view image");
                      },
                      child: Card(
                        elevation: 1,
                        child: Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${snapshot.data.documents[index]['url']}"),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }

  displayProfilePost() {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('UsersPosts')
            .document(widget.userId)
            .collection('UsersPosts')
            .where("postuserId", isEqualTo: widget.userId)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null ||
              snapshot.data.documents.length == 0 ||
              snapshot == null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      child: Icon(
                        MdiIcons.cameraOutline,
                        color: Colors.black,
                        size: 60,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No Vibe Yet",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),
            );
          } else {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (contesxt, index) {
                  return GestureDetector(
                    onTap: profilePostView,
                    child: Card(
                      elevation: 0,
                      child: Container(
                        height: 400,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "${snapshot.data.documents[index]['url']}"),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }

  getAllProfilePost() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await postRefrence
        .document(widget.userId)
        .collection('UsersPosts')
        .where('postuserId', isEqualTo: currentUserUid)
        .orderBy("tiemstamp", descending: true)
        .getDocuments();
    setState(() {
      loading = false;
      postList = querySnapshot.documents
          .map((documentSnapshot) => Post.fromDocument(documentSnapshot))
          .toList();
    });
  }

  Widget userporfilescreen() {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = Firestore.instance.collection('users');

    return Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: users.document(widget.userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data;
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        GestureDetector(
                          onTap: null,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.48,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("${data['photoUrl']}"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width * 0.01,
                            top: MediaQuery.of(context).size.height * 0.07,
                            child: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${data['name']}, ${(DateTime.now().year - data['age'].toDate().year).toString()}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          "My self-summary",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Linkify(
                                onOpen: (link) async {
                                  await launch(link.url);
                                  print(link);
                                },
                                text: """
${data['bio']}""",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                                linkStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      displayProfilePost(),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ));
        },
      ),
    );
  }
}
