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
                  "Edit Profile",
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
              body: ListView(
                children: [],
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

  vibeusquestionsets(text, controller,) {
    return Card(
      child: Container(
        child: Column(
          children: [
            Text(text),

          ],
        ),
      ),
    );
  }
}
