import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nurture/provider_login.dart';
import 'package:nurture/screen_forgot_password.dart';
import 'package:nurture/screen_signup.dart';
import 'package:nurture/widget_loader.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
              width: screenW,
              height: screenH,
              child: Image.asset("assets/doctorone.jpg", fit: BoxFit.fitWidth)),
          SafeArea(
              child: Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: screenH * 0.07),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Image.asset(
                "assets/logoone.png",
                width: 100,
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70.0),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select(
                            (LoginBloc loginBloc) => loginBloc.emailController),
                        cursorColor: Theme.of(context).primaryColor,
                        cursorWidth: 2.0,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            hintText: "user email",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30.0),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select((LoginBloc loginBloc) =>
                            loginBloc.passwordController),
                        obscureText: true,
                        cursorColor: Theme.of(context).primaryColor,
                        cursorWidth: 2.0,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => ForgotPasswordScreen())),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          Provider.of<LoginBloc>(context, listen: false)
                            ..loginUser(context, _scaffoldKey),
                      child: Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 40.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text("Sign In",
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                    ListTile(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignupScreen())),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Need an account?",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "SignUp",
                            textScaleFactor: 1.05,
                            style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )),
          context.select((LoginBloc loginBloc) => loginBloc.loadActive)
              ? CustomLoader()
              : Container()
        ],
      ),
    );
  }
}
