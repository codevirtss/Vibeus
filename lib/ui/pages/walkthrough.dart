import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/pages/login.dart';
import 'package:vibeus/ui/pages/splash.dart';
import 'package:walkthrough/flutterwalkthrough.dart';
import 'package:walkthrough/walkthrough.dart';

class Intro extends StatelessWidget {
  final UserRepository _userRepository;

  Intro({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  /*here we have a list of walkthroughs which we want to have,
      each walkthrough has a title, content and an icon
      */
  final List<Walkthrough> list = [
    Walkthrough(
        title: "Your Privacy on Vibeus",
        content: """
Your privacy is our responsibility
we dont disclose any of our users information. We stricty advice you to read our privacy policy and safety tips
      """,
        imageIcon: MdiIcons.lockCheck),
    Walkthrough(
        title: "Your Chats on Vibeus",
        content: """
Your chats on vibeus are end-to-end encrypted. No one out side of the chat, not even vibeus can read or listen to them.
      """,
        imageIcon: Icons.chat),
    Walkthrough(
      title: "Your Saftey on Vibeus",
      content: """
Meeting new people is exciting, but you should always be cautious when interacting with someone you don’t know.
We stricly advise to read Safety tips inside the app.
We are not responsible for any personal loss.
      """,
      imageIcon: MdiIcons.shieldCheck,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Color color1 = HexColor("#eb4b44");
    //here we need to pass the list and route for the next page to be opened after this
    return Scaffold(
      backgroundColor: color1,
      body: IntroScreen(
        list,
        MaterialPageRoute(
            builder: (context) => Login(
                  userRepository: _userRepository,
                )),
      ),
    );
  }
}
