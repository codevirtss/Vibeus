import 'dart:ui';

import 'package:vibeus/bloc/matches/bloc.dart';
import 'package:vibeus/models/user.dart';
import 'package:vibeus/repositories/matchesRepository.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/userprofile.dart';
import 'package:vibeus/ui/widgets/iconWidget.dart';
import 'package:vibeus/ui/widgets/pageTurn.dart';
import 'package:vibeus/ui/widgets/profile.dart';
import 'package:vibeus/ui/widgets/userGender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'messaging.dart';

// ignore: must_be_immutable
class Matches extends StatefulWidget {
  final String userId;
  UserRepository userRepository;
  Matches({this.userId, this.userRepository});

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchesRepository matchesRepository = MatchesRepository();
  MatchesBloc _matchesBloc;
  TabController controller;

  int difference;

  getDifference(GeoPoint userLocation) async {
    Position position = await Geolocator().getCurrentPosition();

    double location = await Geolocator().distanceBetween(userLocation.latitude,
        userLocation.longitude, position.latitude, position.longitude);

    difference = location.toInt();
  }

  @override
  void initState() {
    _matchesBloc = MatchesBloc(matchesRepository: matchesRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MatchesBloc, MatchesState>(
      cubit: _matchesBloc,
      builder: (BuildContext context, MatchesState state) {
        if (state is LoadingState) {
          _matchesBloc.add(LoadListsEvent(userId: widget.userId));
          return CircularProgressIndicator();
        }
        if (state is LoadUserState) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                centerTitle: true,
                title: Text(
                  "Likes & Matches",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                bottom: TabBar(
                  controller: controller,
                  //  isScrollable: true,
                  indicatorColor: Colors.red,
                  tabs: [
                    Tab(
                      child: Text(
                        "Likes",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Matches",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              body: TabBarView(children: [
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: state.selectedList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            color: backgroundColor,
                          ),
                        );
                      }
                      if (snapshot.data.documents != null) {
                        final user = snapshot.data.documents;
                        return GridView.builder(
                          // Likes wala hai bc ye
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                User selectedUser = await matchesRepository
                                    .getUserDetails(user[index].documentID);
                                User currentUser = await matchesRepository
                                    .getUserDetails(widget.userId);

                                await getDifference(selectedUser.location);
                                // ignore: missing_return

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: profileWidget(
                                      photo: selectedUser.photo,
                                      photoHeight: size.height * 0.81,
                                      padding: size.height * 0.01,
                                      photoWidth: size.width * 0.95,
                                      clipRadius: size.height * 0.01,
                                      containerHeight: size.height * 0.3,
                                      containerWidth: size.width * 0.95,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.height * 0.02),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      userGender(
                                                          selectedUser.gender),
                                                      Expanded(
                                                        child: Text(
                                                          " " +
                                                              selectedUser
                                                                  .name +
                                                              ", " +
                                                              (DateTime.now()
                                                                          .year -
                                                                      selectedUser
                                                                          .age
                                                                          .toDate()
                                                                          .year)
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        difference != null
                                                            ? (difference /
                                                                        1000)
                                                                    .floor()
                                                                    .toString() +
                                                                " km away"
                                                            : "away",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            backgroundColor,
                                                        child: iconWidget(
                                                            Icons.clear, () {
                                                          _matchesBloc.add(
                                                            DeleteUserEvent(
                                                                currentUser:
                                                                    currentUser
                                                                        .uid,
                                                                selectedUser:
                                                                    selectedUser
                                                                        .uid),
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                        }, size.height * 0.04,
                                                            Colors.blue),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.05,
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            backgroundColor,
                                                        child: iconWidget(
                                                            FontAwesomeIcons
                                                                .solidHeart,
                                                            () {
                                                          _matchesBloc.add(
                                                            AcceptUserEvent(
                                                                selectedUser:
                                                                    selectedUser
                                                                        .uid,
                                                                currentUser:
                                                                    currentUser
                                                                        .uid,
                                                                currentUserPhotoUrl:
                                                                    currentUser
                                                                        .photo,
                                                                currentUserName:
                                                                    currentUser
                                                                        .name,
                                                                selectedUserPhotoUrl:
                                                                    selectedUser
                                                                        .photo,
                                                                selectedUserName:
                                                                    selectedUser
                                                                        .name),
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                        }, size.height * 0.04,
                                                            Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      iconWidget(
                                                          Icons
                                                              .account_circle_outlined,
                                                          () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UserProfile(
                                                                          userId:
                                                                              selectedUser.uid,
                                                                          userRepository:
                                                                              widget.userRepository,
                                                                        )));
                                                      }, size.height * 0.06,
                                                          Colors.white)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                child: Container(
                                  height: 708,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${user[index].data['photoUrl']}"))),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 250,
                                        child: Row(
                                          children: [
                                            Text(
                                              "  " + user[index].data['name'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 300,
                                        left: 120,
                                        child: FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor: backgroundColor,
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.blue,
                                              size: 35,
                                            ),
                                            onPressed: () async {
                                              User selectedUser =
                                                  await matchesRepository
                                                      .getUserDetails(
                                                          user[index]
                                                              .documentID);
                                              User currentUser =
                                                  await matchesRepository
                                                      .getUserDetails(
                                                          widget.userId);
                                              _matchesBloc.add(
                                                DeleteUserEvent(
                                                    currentUser:
                                                        currentUser.uid,
                                                    selectedUser:
                                                        selectedUser.uid),
                                              );
                                            }),
                                      ),
                                      Positioned(
                                        top: 300,
                                        right: 130,
                                        child: FloatingActionButton(
                                          elevation: 0,
                                          onPressed: () async {
                                            User selectedUser =
                                                await matchesRepository
                                                    .getUserDetails(
                                                        user[index].documentID);
                                            User currentUser =
                                                await matchesRepository
                                                    .getUserDetails(
                                                        widget.userId);
                                            _matchesBloc.add(
                                              DeleteUserEvent(
                                                  currentUser: currentUser.uid,
                                                  selectedUser:
                                                      selectedUser.uid),
                                            );
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: user.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                        );
                      } else
                        return Container();
                    },
                  ),
                ),

                //,Matches
                Container(
                  color: backgroundColor,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: state.matchedList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(),
                        );
                      }
                      if (snapshot.data.documents != null) {
                        final user = snapshot.data.documents;

                        return GridView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                User selectedUser = await matchesRepository
                                    .getUserDetails(user[index].documentID);
                                User currentUser = await matchesRepository
                                    .getUserDetails(widget.userId);
                                await getDifference(selectedUser.location);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: profileWidget(
                                      photo: selectedUser.photo,
                                      photoHeight: size.height * 0.81,
                                      padding: size.height * 0.01,
                                      photoWidth: size.width * 0.95,
                                      clipRadius: size.height * 0.01,
                                      containerHeight: size.height * 0.3,
                                      containerWidth: size.width * 0.95,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.height * 0.02),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                userGender(selectedUser.gender),
                                                Expanded(
                                                  child: Text(
                                                    " " +
                                                        selectedUser.name +
                                                        ", " +
                                                        (DateTime.now().year -
                                                                selectedUser.age
                                                                    .toDate()
                                                                    .year)
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  difference != null
                                                      ? (difference / 1000)
                                                              .floor()
                                                              .toString() +
                                                          " km away"
                                                      : "away",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      size.height * 0.02),
                                                  child: iconWidget(
                                                      Icons.message, () {
                                                    _matchesBloc.add(
                                                      OpenChatEvent(
                                                          currentUser:
                                                              widget.userId,
                                                          selectedUser:
                                                              selectedUser.uid),
                                                    );
                                                    pageTurn(
                                                        Messaging(
                                                            currentUser:
                                                                currentUser,
                                                            selectedUser:
                                                                selectedUser),
                                                        context);
                                                  }, size.height * 0.04,
                                                      Colors.white),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      size.height * 0.04),
                                                  child: iconWidget(
                                                      Icons.account_circle, () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    UserProfile(
                                                                      userId:
                                                                          selectedUser
                                                                              .uid,
                                                                      userRepository:
                                                                          widget
                                                                              .userRepository,
                                                                    )));
                                                  }, size.height * 0.04,
                                                      Colors.white),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                child: Container(
                                  height: 708,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${user[index].data['photoUrl']}"))),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 250,
                                        child: Row(
                                          children: [
                                            Text(
                                              "  " + user[index].data['name'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 300,
                                        left: 120,
                                        child: FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor: backgroundColor,
                                            child: Icon(
                                              Icons.chat,
                                              color: Colors.black,
                                              size: 35,
                                            ),
                                            onPressed: () async {
                                              User selectedUser =
                                                  await matchesRepository
                                                      .getUserDetails(
                                                          user[index]
                                                              .documentID);
                                              User currentUser =
                                                  await matchesRepository
                                                      .getUserDetails(
                                                          widget.userId);
                                              _matchesBloc.add(
                                                OpenChatEvent(
                                                    currentUser: widget.userId,
                                                    selectedUser:
                                                        selectedUser.uid),
                                              );
                                              pageTurn(
                                                  Messaging(
                                                      currentUser: currentUser,
                                                      selectedUser:
                                                          selectedUser),
                                                  context);
                                            }),
                                      ),
                                      
                                      Positioned(
                                        top: 300,
                                        right: 130,
                                        child: FloatingActionButton(
                                          elevation: 0,
                                          onPressed: () async {
                                            User selectedUser =
                                                await matchesRepository
                                                    .getUserDetails(
                                                        user[index].documentID);
                                            User currentUser =
                                                await matchesRepository
                                                    .getUserDetails(
                                                        widget.userId);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfile(
                                                          userId:
                                                              selectedUser.uid,
                                                          userRepository: widget
                                                              .userRepository,
                                                        )));
                                          },
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                            size: 45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: user.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Container(),
                        );
                      }
                    },
                  ),
                ),
              ]),
            ),
          );
        }
        return Container();
      },
    );
  }
}
