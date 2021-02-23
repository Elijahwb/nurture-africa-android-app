import 'dart:ui';
import 'package:nurture/provider_forgot_password.dart';
import 'package:nurture/widget_loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
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
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/doctorone.jpg",
                  fit: BoxFit.fitWidth,
                ),
              )),
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
                            (ForgotPasswordBloc forgotPasswordBloc) =>
                                forgotPasswordBloc.usernameController),
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
                            hintText: "user email",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5))),
                      ),
                    ),
                    context.select((ForgotPasswordBloc forgotPasswordBloc) =>
                            forgotPasswordBloc.emailExists)
                        ? Container(
                            margin: EdgeInsets.only(top: 15.0),
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              controller: context.select(
                                  (ForgotPasswordBloc forgotPasswordBloc) =>
                                      forgotPasswordBloc.newPasswordController),
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
                                          color:
                                              Theme.of(context).primaryColor)),
                                  hintText: "new password",
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5))),
                            ),
                          )
                        : Container(),
                    context.select((ForgotPasswordBloc forgotPasswordBloc) =>
                            forgotPasswordBloc.emailExists)
                        ? Container(
                            margin: EdgeInsets.only(top: 15.0),
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              controller: context.select(
                                  (ForgotPasswordBloc forgotPasswordBloc) =>
                                      forgotPasswordBloc
                                          .confirmPasswordController),
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
                                          color:
                                              Theme.of(context).primaryColor)),
                                  hintText: "confirm password",
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5))),
                            ),
                          )
                        : Container(),
                    !context.select((ForgotPasswordBloc forgotPasswordBloc) =>
                            forgotPasswordBloc.emailExists)
                        ? GestureDetector(
                            onTap: () => Provider.of<ForgotPasswordBloc>(
                                context,
                                listen: false)
                              ..submitUserEmail(context, _scaffoldKey),
                            child: Container(
                                margin: EdgeInsets.only(top: 30),
                                height: 40.0,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text("Submit",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          )
                        : Container(),
                    context.select((ForgotPasswordBloc forgotPasswordBloc) =>
                            forgotPasswordBloc.emailExists)
                        ? GestureDetector(
                            onTap: () => Provider.of<ForgotPasswordBloc>(
                                context,
                                listen: false)
                              ..changePassword(context, _scaffoldKey),
                            child: Container(
                                margin: EdgeInsets.only(top: 30),
                                height: 40.0,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text("Change Password",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          )
                        : Container(),
                  ],
                ),
              ),
            ]),
          )),
          context.select((ForgotPasswordBloc forgotPasswordBloc) =>
                  forgotPasswordBloc.loadActive)
              ? CustomLoader()
              : Container()
        ],
      ),
    );
  }
}
