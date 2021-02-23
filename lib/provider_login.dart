import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nurture/global_content.dart';
import 'package:nurture/screen_landing.dart';
import 'package:http/http.dart' as http;
import 'package:nurture/styling.dart';

class LoginBloc with ChangeNotifier {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _loaderActive = false;

  LoginBloc() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  _loginUser(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    _loaderActive = true;
    notifyListeners();

    if (validateText(_emailController.text) &&
        validateText(_passwordController.text)) {
      final response = await http.post("$apiMainUrl/nurtureLoginUser.php",
          body: {
            "email": _emailController.text,
            "password": _passwordController.text
          }).timeout(Duration(seconds: 10), onTimeout: () {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: secondaryColor,
          content: Text("Connection Has Timedout!",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ));
        return null;
      });

      _loaderActive = false;
      notifyListeners();

      if (response.statusCode == 200) {
        var message = json.decode(response.body);

        if (message[0]['valid'] == "TRUE") {
          globalUser.name = message[1]['name'];
          globalUser.email = message[1]['email'];
          globalUser.phone = message[1]['phone'];
          globalUser.password = message[1]['password'];
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LandingScreen()));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: secondaryColor,
            content: Text("Wrong Credentials or Account Does Not Exist",
                style: TextStyle()),
          ));
        }
      }
    } else {
      _loaderActive = false;
      notifyListeners();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: secondaryColor,
        content: Text("Please Fill In All The Form Fields"),
      ));
    }
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get loadActive => _loaderActive;
  Function get loginUser => _loginUser;
}
