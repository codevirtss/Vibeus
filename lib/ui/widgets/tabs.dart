import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vibeus/models/user.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/pages/matches.dart';
import 'package:vibeus/ui/pages/messages.dart';
import 'package:vibeus/ui/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:vibeus/ui/pages/userprofile.dart';
import '../constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

User user; //yaha se le raha hai uesrs

final userRefrence = Firestore.instance.collection("users");

// ignore: must_be_immutable
class Tabs extends StatefulWidget {
  UserRepository userRepository;
  final userId;
  final User user;

  Tabs({this.userId, this.user, this.userRepository});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var padding = EdgeInsets.symmetric(horizontal: 18,vertical: 5);
  double gap =10;
  // ignore: unused_field
  String _debugLabelString = "";
  int _page = 0;

  Future<void> notifiyer() async {
    OneSignal.shared.init('e4eeddce-b510-494b-b57d-54cf930e16a1');
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init("YOUR_ONESIGNAL_APP_ID", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      this.setState(() {
        _debugLabelString =
            "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
    });

    OSPermissionSubscriptionState status =
        await OneSignal.shared.getPermissionSubscriptionState();

    String playerId = status.subscriptionStatus.userId;
    print(playerId);
    Firestore.instance
        .collection('users')
        .document(widget.userId)
        .collection('notifiyerId')
        .document()
        .setData({
      "playerId": playerId,
    });
  }

  @override
  void initState() {
    notifiyer();
    super.initState();
  }

  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Search(
        userId: widget.userId,
        userRepository: widget.userRepository,
      ),
      Matches(
        userId: widget.userId,
      ),
      Messages(
        userId: widget.userId,
      ),
      UserProfile(userRepository: widget.userRepository, userId: widget.userId),
    ];

    return Theme(
      data: ThemeData(
        primaryColor: backgroundColor,
        accentColor: Colors.white,
      ),
      child: Scaffold(
        body: PageView.builder(
            itemCount: 4,
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _page = page;
              });
            },
            itemBuilder: (context, position) {
              return Container(
                child: pages[position],
              );
            }),
        bottomNavigationBar:SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0,25),
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
              child: GNav(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 900),
                tabs: [
                  GButton(
                    gap: gap,
                    icon: Icons.explore_outlined,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.purple,
                    text: 'Discover',
                    textColor: Colors.purple,
                    backgroundColor: Colors.purple.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.heart_o,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.pink,
                    text: 'Like',
                    textColor: Colors.pink,
                    backgroundColor: Colors.pink.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: Icons.chat_outlined,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.grey,
                    text: 'Chat',
                    textColor: Colors.grey,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.user,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.teal,
                    text: 'Home',
                    textColor: Colors.teal,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                ],
                selectedIndex: _page,
                onTabChange: (index){
                  setState(() {
                    _page =index;
                  });
                  controller.jumpToPage(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget addbottomsheet() {
  return Container(
    height: 100.0,
    //  width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        Text(
          'Chose profile photo',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  //        takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera")),
            FlatButton.icon(
                onPressed: () {
                  //     takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"))
          ],
        ),
      ],
    ),
  );
}
