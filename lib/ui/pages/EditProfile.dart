import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/vibeusques.dart';
import 'package:vibeus/ui/widgets/gender.dart';

class EditProile extends StatefulWidget {
  final String documentId;
  final String userId;

  EditProile({
    this.documentId,
    this.userId,
  });

  @override
  _EditProileState createState() => _EditProileState();
}

class _EditProileState extends State<EditProile> {
  // ignore: unused_field
  final TextEditingController _biocontroller = TextEditingController();

  File photo;

  CollectionReference users = Firestore.instance.collection('users');

  Future<void> updatePorifle(File photo, String userId) async {
    StorageUploadTask storageUploadTask;
    storageUploadTask = FirebaseStorage.instance
        .ref()
        .child('userPhotos')
        .child(userId)
        .putFile(photo);

    return await storageUploadTask.onComplete.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        await Firestore.instance
            .collection('users')
            .document(userId)
            .updateData({
          'photoUrl': url,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = Firestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.document(widget.userId).get(),
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
                  IconButton(
                      icon: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.blue,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        print(photo);
                        updatePorifle(photo, widget.userId);
                      })
                ],
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 70.0,
                        backgroundImage: photo == null
                            ? NetworkImage("${data['photoUrl']}")
                            : FileImage(photo)),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                            ),
                            context: context,
                            builder: ((builder) => socialbottomSheet()));
                      },
                      child: Text(
                        "Change profile image",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateName(
                                      userId: widget.userId,
                                    )));
                      },
                      title: Text(
                        "Update name",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateBio(
                                      userId: widget.userId,
                                    )));
                      },
                      title: Text(
                        "Update Bio",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpadatePrefrence(
                                      userId: widget.userId,
                                    )));
                      },
                      title: Text(
                        "Update Prefrences",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VibeusQues(
                                      userId: widget.userId,
                                    )));
                      },
                      title: Text(
                        "Vibeus questionnaire",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        });
  }

  Widget textFieldWidget(controller, text, size, lines) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: TextField(
        controller: controller,
        maxLines: lines,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Colors.black, fontSize: 18),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget socialbottomSheet() {
    return Container(
      height: 150.0,
      //  width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Chose profile image',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: imagefromcammera,
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              FlatButton.icon(
                  onPressed: imagefromgallery,
                  icon: Icon(Icons.image),
                  label: Text("Gallery"))
            ],
          ),
        ],
      ),
    );
  }

  imagefromcammera() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 680,
        maxWidth: 970,
        imageQuality: 40);
    setState(() {
      this.photo = imageFile;
    });
  }

  imagefromgallery() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 680,
      maxWidth: 970,
    );
    setState(() {
      this.photo = imageFile;
    });
  }
}

class UpdateName extends StatefulWidget {
  final UserRepository userRepository;
  final String documentId;
  final String userId;

  UpdateName({this.documentId, this.userId, this.userRepository});

  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  final TextEditingController _namecontrolle = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = Firestore.instance.collection('users');
    return FutureBuilder(
      future: users.document(widget.userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: backgroundColor,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Update Name",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _namecontrolle,
                    // initialValue: "${data['name']}",
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter name' : null,
                    autocorrect: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("""
Help people discover your account by using the name that
you're known by: either your full name or nickname.
              """),
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await users
                          .document(widget.userId)
                          .updateData(({
                            'name': _namecontrolle.text,
                          }))
                          .then((value) => print("User Updated"))
                          .catchError((e) {
                        print(e.toString());
                      });
                      Navigator.pop(context);
                    } else {
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }

  showSnackBar() {
    return SnackBar(content: Text("Profile Updated"));
  }

  CollectionReference users = Firestore.instance.collection('users');

  Future<void> updateName(String name) async {
    return users
        .document(widget.userId)
        .updateData(({
          'name': _namecontrolle.text,
        }))
        .then((value) => print("User Updated"))
        .catchError((e) {
      print(e.toString());
    });
  }
}

class UpdateBio extends StatefulWidget {
  final UserRepository userRepository;
  final String userId;
  final String documnetId;

  UpdateBio({Key key, this.userRepository, this.userId, this.documnetId})
      : super(key: key);
  @override
  _UpdateBioState createState() => _UpdateBioState();
}

class _UpdateBioState extends State<UpdateBio> {
  final TextEditingController _biocontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = Firestore.instance.collection('users');
    return FutureBuilder(
      future: users.document(widget.userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // ignore: unused_local_variable
          Map<String, dynamic> data = snapshot.data.data;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: backgroundColor,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Update Bio",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    maxLines: 5,
                    controller: _biocontroller,
                    //   initialValue: "${data['name']}",
                    validator: (val) => val.isEmpty || val.length > 100
                        ? 'Bio invalid or to long'
                        : null,
                    autocorrect: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("""
Help people to know about you by using Vibeus Bio Feature.
Write about you likes and dislikes
Your Hobbies  and many more
              """),
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await users
                          .document(widget.userId)
                          .updateData(({
                            'bio': _biocontroller.text,
                          }))
                          .then((value) => print("User Updated"))
                          .catchError((e) {
                        print(e.toString());
                      });

                      Navigator.pop(context);
                      showSnackBar();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }

  showSnackBar() {
    return SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          "Profile Updated",
          style: TextStyle(color: Colors.white),
        ));
  }
}

class UpadatePrefrence extends StatefulWidget {
  final String userId;
  final UserRepository userRepository;

  const UpadatePrefrence({Key key, this.userId, this.userRepository})
      : super(key: key);
  @override
  _UpadatePrefrenceState createState() => _UpadatePrefrenceState();
}

class _UpadatePrefrenceState extends State<UpadatePrefrence> {
  String gender, interestedIn;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference users = Firestore.instance.collection('users');
    return FutureBuilder(
      future: users.document(widget.userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // ignore: unused_local_variable
          Map<String, dynamic> data = snapshot.data.data;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: backgroundColor,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Update Prefrences",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                  child: Text(
                    "You Are",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    genderWidget(
                        FontAwesomeIcons.female, "Female", size, gender, () {
                      setState(() {
                        gender = "Female";
                      });
                    }),
                    genderWidget(FontAwesomeIcons.male, "Male", size, gender,
                        () {
                      setState(() {
                        gender = "Male";
                      });
                    }),
                    genderWidget(
                      FontAwesomeIcons.transgenderAlt,
                      "Transgender",
                      size,
                      gender,
                      () {
                        setState(
                          () {
                            gender = "Transgender";
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                  child: Text(
                    "Looking For",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    genderWidget(
                        FontAwesomeIcons.female, "Female", size, interestedIn,
                        () {
                      setState(() {
                        interestedIn = "Female";
                      });
                    }),
                    genderWidget(
                        FontAwesomeIcons.male, "Male", size, interestedIn, () {
                      setState(() {
                        interestedIn = "Male";
                      });
                    }),
                    genderWidget(
                      FontAwesomeIcons.transgenderAlt,
                      "Transgender",
                      size,
                      interestedIn,
                      () {
                        setState(
                          () {
                            interestedIn = "Transgender";
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () async {
                    print(gender);
                    print(interestedIn);
                    await users.document(widget.userId).updateData(
                        ({'gender': gender, 'interestedIn': interestedIn}));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.red)),
                )
              ],
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }
}
