import 'package:vibeus/bloc/authentication/authentication_bloc.dart';
import 'package:vibeus/bloc/authentication/authentication_state.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/pages/profile.dart';
import 'package:vibeus/ui/pages/splash.dart';
import 'package:vibeus/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';

class Home extends StatelessWidget {
  final UserRepository _userRepository;

  Home({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Splash();
          }
          if (state is Authenticated) {
            return Tabs(
              userRepository: _userRepository,
              userId: state.userId,
            );
          }
          if (state is AuthenticatedButNotSet) {
            return Profile(
              userRepository: _userRepository,
              userId: state.userId,
            );
          }
          if (state is Unauthenticated) {
            return Login(
              userRepository: _userRepository,
            );
         
          } else
            return Container();
        },
      ),
    );
  }
}
