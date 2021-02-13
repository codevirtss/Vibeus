import 'package:flutter/material.dart';
import 'package:vibeus/ui/constants.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "About Vibeus",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "App Version",
                    style: TextStyle(
                        color: Colors.black,
                        
                        fontSize: 20),
                  ),
                 
                  trailing: Text("Vibeus App v1.0.2")
                ),
              ),
                Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "Version",
                    style: TextStyle(
                        color: Colors.black,
                        
                        fontSize: 20),
                  ),
                 
                  trailing: Text("3")
                ),
              ),
             

            ],
          ),
        ));
  }
}

