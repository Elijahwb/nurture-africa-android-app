import 'dart:ui';
import 'package:nurture/provider_signup.dart';
import 'package:nurture/widget_loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
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
              child: Image.asset(
                "assets/doctorone.jpg",
                fit: BoxFit.fitWidth,
              )),
          SafeArea(
              child: Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: screenH * 0.06),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Image.asset(
                "assets/logoone.png",
                width: 100,
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70.0, bottom: 15),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select((SignupBloc signupBloc) =>
                            signupBloc.fullnameController),
                        cursorColor: Theme.of(context).primaryColor,
                        cursorWidth: 2.0,
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                            hintText: "full name",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select((SignupBloc signupBloc) =>
                            signupBloc.usernameController),
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
                            hintText: "username",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select((SignupBloc signupBloc) =>
                            signupBloc.passwordController),
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
                            hintText: "password",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select((SignupBloc signupBloc) =>
                            signupBloc.phoneController),
                        cursorColor: Theme.of(context).primaryColor,
                        cursorWidth: 2.0,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor),
                        keyboardType: TextInputType.phone,
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
                            hintText: "phone number",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: context.select((SignupBloc signupBloc) =>
                            signupBloc.emailController),
                        cursorColor: Theme.of(context).primaryColor,
                        cursorWidth: 2.0,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor),
                        keyboardType: TextInputType.emailAddress,
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
                            hintText: "email",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Provider.of<SignupBloc>(context, listen: false)
                            ..signupUser(context, _scaffoldKey),
                      child: Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 40.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                    ListTile(
                      onTap: () => Navigator.of(context).pop(),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "LogIn",
                            style: TextStyle(
                                fontSize: 12.5,
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
          context.select((SignupBloc signupBloc) => signupBloc.loadActive)
              ? CustomLoader()
              : Container()
        ],
      ),
    );
  }
}
