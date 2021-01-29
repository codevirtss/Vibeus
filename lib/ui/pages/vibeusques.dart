import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibeus/ui/constants.dart';

class VibeusQues extends StatefulWidget {
  final String documentId;
  final String userId;

  VibeusQues({this.documentId, this.userId});
  @override
  _VibeusQuesState createState() => _VibeusQuesState();
}

class _VibeusQuesState extends State<VibeusQues> {
  @override
  Widget build(BuildContext context) {
    CollectionReference user = Firestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.document(widget.userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data;
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: backgroundColor,
                iconTheme: IconThemeData(color: Colors.black),
                title: Text(
                  "Vibeus Questions",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.done,
                          size: 30,
                          color: Colors.blue,
                        ),
                        onPressed: () async {}),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("You"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Which word describes you better?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('carefree'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('intense'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("My ideal person"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Which word describes you better?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('carefree'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('intense'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                        ],
                      ),
                    ),
                     Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("You"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Do you enjoy discussing politics?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('yes'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('no'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("My ideal person"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Do you enjoy discussing politics?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('yes '),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('no'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                        ],
                      ),
                    ),
                     Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("You"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                             "Is astrological sign at all important in a match?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('yes'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('no'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("My ideal person"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Is astrological sign at all important in a match?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('yes'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('no'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                        ],
                      ),
                    ),
                     Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("You"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Should women continue to work full-time after marriage?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('yes'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('no'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                            ListTile(
                            title: const Text("either way, it's their choice"),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text("only if it's necessary"),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("My ideal person"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Which word describes you better?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('carefree'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('intense'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                        ],
                      ),
                    ),
                     Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("You"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Which word describes you better?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('carefree'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('intense'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("My ideal person"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Which word describes you better?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('carefree'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                          ListTile(
                            title: const Text('intense'),
                            leading: Radio(
                                // value: ,
                                //  groupValue: _site,
                                // onChanged: (BestTutorSite value) {
                                //   setState(() {
                                //     _site = value;
                                //   });
                                // },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blue,
          ),
        );
      },
    );
  }
}
