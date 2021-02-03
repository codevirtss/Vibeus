import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vibeus/bloc/authentication/authentication_bloc.dart';
import 'package:vibeus/bloc/authentication/authentication_event.dart';
import 'package:vibeus/bloc/login/bloc.dart';
import 'package:vibeus/repositories/userRepository.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/ProfileVerification.dart';
import 'package:vibeus/ui/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeus/ui/pages/splash.dart';
import 'package:email_validator/email_validator.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Color color1 = HexColor("#eb4b44");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Login Failed"),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }

        if (state.isSubmitting) {
          print("isSubmitting");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" Logging In..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              width: 500,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CarouselSlider(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 200),
                    viewportFraction: 0.8,
                    pauseAutoPlayOnTouch: Duration(seconds: 2),
                    items: [
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('images/privacy.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('images/likes.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('images/chater.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('images/chat.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Vibeus",
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.005,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _emailController,
                      // ignore: deprecated_member_use
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? "Invalid Email" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Colors.black, fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      // ignore: deprecated_member_use
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? "Invalid Password"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Colors.black, fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 25, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPassword()));
                          },
                          child: Text(
                            "Forget password",
                            style: TextStyle(fontSize: 18, color: color1),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Column(
                      children: <Widget>[
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: isLoginButtonEnabled(state)
                              ? color1
                              : Colors.grey,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: isLoginButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                            child: Text("Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUp(
                                    userRepository: _userRepository,
                                  );
                                },
                              ),
                            );
                          },
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Don\'t have an Account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                //     fontFamily: "Satisfy",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Create Account',
                              style: TextStyle(
                                color: color1,
                                fontSize: 18.0,
                                //     fontFamily: "Satisfy",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  Color color1 = HexColor("#eb4b44");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          "Password Reset",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Text("""
In order to implement a proper user management system, systems integrate a Forgot Password service that allows the user to request a password reset
              """),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: TextFormField(
                controller: _emailController,
                // ignore: deprecated_member_use
                autovalidate: true,
                validator: (input) {
                  final bool isValid = EmailValidator.validate(input);
                  return isValid ? null : "Invalid email";
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: Colors.black, fontSize: size.height * 0.03),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.05),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: color1,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    sendresetlink(_emailController.text);
                  },
                  child: Text("Reset Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendresetlink(String email) {
    return FirebaseAuth.instance
        .sendPasswordResetEmail(
          email: email,
        )
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => {
              showemialsentDialog(
                context: context,
              ),
              Navigator.of(context),
            });
  }

  showemialsentDialog(
      {BuildContext context,
      CustomDialogBox Function(BuildContext context) builder}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Vibeus Password Reset",
            descriptions:
                "Passowrd reset link has been successfully sent to your email address",
            text: "Thanks",
          );
        });
  }
}
