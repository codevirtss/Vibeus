import 'dart:io';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibeus/bloc/messaging/bloc.dart';
import 'package:vibeus/bloc/messaging/messaging_bloc.dart';
import 'package:vibeus/models/message.dart';
import 'package:vibeus/models/user.dart';
import 'package:vibeus/repositories/messaging.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/userprofile.dart';
import 'package:vibeus/ui/widgets/message.dart';
import 'package:vibeus/ui/widgets/photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipOval(
              child: Container(
                height: size.height * 0.06,
                width: size.height * 0.06,
                child: PhotoWidget(
                  photoLink: widget.selectedUser.photo,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfile(
                                userId: widget.selectedUser.uid,
                                userRepository: widget.userRepository,
                              )));
                },
                child: Text(
                  widget.selectedUser.name,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.video_call,
        //       color: Colors.black,
        //       size: 30,
        //     ),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: Icon(
        //       Icons.location_pin,
        //       color: Colors.black,
        //       size: 30,
        //     ),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => VibeusDate()));
        //     },
        //   )
        // ],
      ),
      body: BlocBuilder<MessagingBloc, MessagingState>(
        bloc: _messagingBloc,
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
                      return Center(
                        child: Text(
                          "Start the conversation?",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    if (snapshot.data.documents.isNotEmpty) {
                      return Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                // reverse: true,
                                scrollDirection: Axis.vertical,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Start the conversation ?",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
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
                              icon: Icon(Icons.face),
                            ),
                          ],
                        ),
                      ),
                      isWriting
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.record_voice_over),
                            ),
                      isWriting
                          ? Container()
                          : GestureDetector(
                              child: Icon(Icons.camera_alt),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          "Vibeus Date",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: ListView(
          children: [
            horizontalsuggestions(),
          ],
        ),
      ),
    );
  }

  horizontalsuggestions() {
    return CircleAvatar(
      radius: 10,
    );
  }
}
