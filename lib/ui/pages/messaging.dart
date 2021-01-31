import 'dart:io';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vibeus/bloc/messaging/bloc.dart';
import 'package:vibeus/bloc/messaging/messaging_bloc.dart';
import 'package:vibeus/models/message.dart';
import 'package:vibeus/models/user.dart';
import 'package:vibeus/repositories/messaging.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/userprofile.dart';
import 'package:vibeus/ui/widgets/message.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: must_be_immutable
class Messaging extends StatefulWidget {
  final User currentUser, selectedUser;
  UserRepository userRepository;

  Messaging({this.currentUser, this.selectedUser, this.userRepository});

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  User currentUser, selectedUser;
  TextEditingController _messageTextController = TextEditingController();
  MessagingRepository _messagingRepository = MessagingRepository();
  FocusNode textFieldFocus = FocusNode();
  MessagingBloc _messagingBloc;
  bool isValid = false;
  bool showEmojiPicker = false;
  bool isWriting = false;
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    _messagingBloc = MessagingBloc(messagingRepository: _messagingRepository);

    _messageTextController.text = '';
    _messageTextController.addListener(() {
      setState(() {
        isValid = (_messageTextController.text.isEmpty) ? false : true;
      });
    });
    print(widget.selectedUser.photo);
    print(widget.selectedUser.url);
    print("Raza Khan");
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    print("Message Submitted");

    _messagingBloc.add(
      SendMessageEvent(
        message: Message(
          text: _messageTextController.text,
          senderId: widget.currentUser.uid,
          senderName: widget.currentUser.name,
          selectedUserId: widget.selectedUser.uid,
          photo: null,
        ),
      ),
    );
    _messageTextController.clear();
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }
  }

  emojiContainer() {
    return EmojiPicker(
      bgColor: Color(0xff272c35),
      indicatorColor: Colors.black,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting = true;
        });

        _messageTextController.text = _messageTextController.text + emoji.emoji;
      },
      recommendKeywords: ["face", "happy", "party", "sad"],
      numRecommended: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // leading:  IconButton(
        //           onPressed: () {
        //             Navigator.of(context);
        //           },
        //           icon: Icon(Icons.clear,
        //           color: ,
        //           ),
        //         ),
        backgroundColor: backgroundColor,
        elevation: 0,
        bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(""),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile(
                                      userId: widget.selectedUser.uid,
                                      userRepository: widget.userRepository,
                                    )));
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(widget.selectedUser.photo),
                      ),
                    ),
                    Text(
                      widget.selectedUser.name,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                Icon(
                  Icons.more_vert,
                  size: 30,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(20)),
      ),
      body: BlocBuilder<MessagingBloc, MessagingState>(
        cubit: _messagingBloc,
        builder: (BuildContext context, MessagingState state) {
          if (state is MessagingInitialState) {
            _messagingBloc.add(
              MessageStreamEvent(
                  currentUserId: widget.currentUser.uid,
                  selectedUserId: widget.selectedUser.uid),
            );
          }
          if (state is MessagingLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MessagingLoadedState) {
            Stream<QuerySnapshot> messageStream = state.messageStream;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: messageStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Card(
                        child: Center(
                          child: Text(
                            "Start the conversation?",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    if (snapshot.data.documents.isNotEmpty) {
                      return Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return MessageWidget(
                                    currentUserId: widget.currentUser.uid,
                                    messageId: snapshot
                                        .data.documents[index].documentID,
                                  );
                                },
                                itemCount: snapshot.data.documents.length,
                              ),
                            ),
                            showEmojiPicker
                                ? Container(child: emojiContainer())
                                : Container(),
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            color: backgroundColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      """
Your chats on vibeus are end-to-end encrypted.
No one out side of the chat,
not even vibeus can read or listen to them.
      """,
                                      style: TextStyle(
                                          color: Colors.orange[200],
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          File photo = await FilePicker.getFile(
                              type: FileType.image, allowCompression: true);
                          if (photo != null) {
                            _messagingBloc.add(
                              SendMessageEvent(
                                message: Message(
                                    text: null,
                                    senderName: widget.currentUser.name,
                                    senderId: widget.currentUser.uid,
                                    photo: photo,
                                    selectedUserId: widget.selectedUser.uid),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff00b6f3), Color(0xff0184dc)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              controller: _messageTextController,
                              focusNode: textFieldFocus,
                              onTap: () => hideEmojiContainer(),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (val) {
                                (val.length > 0 && val.trim() != "")
                                    ? setWritingTo(true)
                                    : setWritingTo(false);
                              },
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(50.0),
                                    ),
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                if (!showEmojiPicker) {
                                  // keyboard is visible
                                  hideKeyboard();
                                  showEmojiContainer();
                                } else {
                                  //keyboard is hidden
                                  showKeyboard();
                                  hideEmojiContainer();
                                }
                              },
                              icon: Icon(
                                Icons.face,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      isWriting
                          ? Container()
                          : GestureDetector(
                              child: Icon(
                                Icons.camera_alt,
                                size: 30,
                              ),
                              onTap: () async {
                                File photo = await ImagePicker.pickImage(
                                    source: ImageSource.camera,
                                    maxHeight: 680,
                                    maxWidth: 970,
                                    imageQuality: 40);
                                if (photo != null) {
                                  _messagingBloc.add(
                                    SendMessageEvent(
                                      message: Message(
                                          text: null,
                                          senderName: widget.currentUser.name,
                                          senderId: widget.currentUser.uid,
                                          photo: photo,
                                          selectedUserId:
                                              widget.selectedUser.uid),
                                    ),
                                  );
                                }
                              }),
                      isWriting
                          ? GestureDetector(
                              onTap: isValid ? _onFormSubmitted : null,
                              child: Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xff00b6f3),
                                          Color(0xff0184dc)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Transform(
                                    child: Icon(Icons.send),
                                    alignment: FractionalOffset.center,
                                    transform: new Matrix4.identity()
                                      ..rotateY(45 * 3.1415927 / 180),
                                  ),
                                ),
                              ))
                          : Container()
                    ],
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  setWritingTo(bool val) {
    setState(() {
      isWriting = val;
    });
  }
}

class VibeusDate extends StatefulWidget {
  @override
  _VibeusDateState createState() => _VibeusDateState();
}

class _VibeusDateState extends State<VibeusDate> {
  TabController controller;
//DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController exploreTextEditingController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
            title: TextField(
              controller: exploreTextEditingController,
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.mic,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.qr_code_scanner,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {})
            ],
            bottom: TabBar(controller: controller, isScrollable: true, tabs: [
              Tab(
                child: Text('Posts', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.grid,
                  color: Colors.black,
                ),
              ),

              Tab(
                child: Text('Flare', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.motionPlay,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text('Plub', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.playBox,
                  color: Colors.black,
                ),
              ),

              Tab(
                child: Text('Pluts', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.feather,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text('Shop', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.shopping,
                  color: Colors.black,
                ),
              ),
              //
              Tab(
                child: Text('Alive', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.videoWireless,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text('Music', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.music,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text('Beauty', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.faceWoman,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text('Science & Technilogy',
                    style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.brain,
                  color: Colors.black,
                ),
              ),
              Tab(
                child:
                    Text('Programing', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.codeTags,
                  color: Colors.black,
                ),
              ),

              Tab(
                child: Text('Sports', style: TextStyle(color: Colors.black)),
                icon: Icon(
                  MdiIcons.baseballBat,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Text(
                  "Fitness",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                icon: Icon(
                  MdiIcons.dumbbell,
                  color: Colors.black,
                ),
              ),
            ])),
        body: TabBarView(controller: controller, children: [
          Container(
            child: exPosts(),
          ),
          Container(
            child: exFlare(),
          ),
          Container(
            child: exPlubs(),
          ),
          // Container(
          //   child: exBlogs(),
          // ),
          Container(
            child: exPluts(),
          ),
          Container(
            child: exShop(),
          ),
          Container(
            child: exAlive(),
          ),
          Container(child: exMusic()),
          Container(
            child: exBeauty(),
          ),
          Container(
            child: exScienceTech(),
          ),
          Container(child: exProgaming()),
          Container(
            child: exSports(),
          ),
          Container(
            child: exFitness(),
          ),
        ]),
      ),
    );
  }

  Widget exPosts() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      // child:NetworkImage("https://unsplash.com/s/photos/Center(child: Text("Explore Photos")),
                      child: Center(child: Text("Explore Posts")),
                    ),
                  ))),
    );
  }

  Widget exFlare() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Flare")),
                    ),
                  ))),
    );
  }

  Widget exPlubs() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Videos")),
                    ),
                  ))),
    );
  }

  Widget exPluts() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Pluts")),
                    ),
                  ))),
    );
  }

  Widget exShop() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Shoping")),
                    ),
                  ))),
    );
  }

  Widget exAlive() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Streaming")),
                    ),
                  ))),
    );
  }

  Widget exMusic() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Musics")),
                    ),
                  ))),
    );
  }

  Widget exBeauty() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Beauty")),
                    ),
                  ))),
    );
  }

  Widget exScienceTech() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 1,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child:
                          Center(child: Text("Explore Science & Technology")),
                    ),
                  ))),
    );
  }

  Widget exProgaming() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Coding")),
                    ),
                  ))),
    );
  }

  Widget exSports() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Sports")),
                    ),
                  ))),
    );
  }

  Widget exFitness() {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 1,
                    child: Container(
                      child: Center(child: Text("Explore Fittness")),
                    ),
                  ))),
    );
  }
}
