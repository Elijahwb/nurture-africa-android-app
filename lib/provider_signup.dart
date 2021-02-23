import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nurture/global_content.dart';
import 'package:http/http.dart' as http;
import 'package:nurture/styling.dart';

class SignupBloc with ChangeNotifier {
  TextEditingController _fullnameController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  bool _loaderActive = false;

  SignupBloc() {
    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  _clearControllers() {
    _fullnameController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _emailController.clear();
  }

  _signupUser(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    _loaderActive = true;
    notifyListeners();

    var response;

    if (validateText(_fullnameController.text) &&
        validateText(_usernameController.text) &&
        validateText(_passwordController.text) &&
        validateText(_phoneController.text) &&
        validateText(_emailController.text)) {
      response = await http.post(
          "https://damgroup.000webhostapp.com/nurtureRegisterUser.php",
          body: {
            "fullname": _fullnameController.text,
            "username": _usernameController.text,
            "password": _passwordController.text,
            "phone": _phoneController.text,
            "email": _emailController.text,
          }).timeout(Duration(seconds: 10), onTimeout: () {
        _loaderActive = false;
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Connection Has TimedOut"),
        ));
        notifyListeners();
        return null;
      });

      if (response.statusCode == 200) {
        _loaderActive = false;

        notifyListeners();
        var message = json.decode(response.body);
        if (message["REGISTERED"] == "SUCCESSFUL") {
          _clearControllers();

          Navigator.of(context).pop();
        } else {
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text("A Problem Occured! Try Again."),
              ));
        }
      } else {
        _loaderActive = false;

        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Registeration Failed! Check Internet Connection"),
        ));
        notifyListeners();
      }
    } else {
      _loaderActive = false;
      scaffoldKey.currentState.showSnackBar(SnackBar(
        elevation: 2.5,
        backgroundColor: secondaryColor,
        content: Text("Please Fill In All The Form Fields!",
            style: TextStyle(
              color: Colors.white,
            )),
      ));
      notifyListeners();
    }
  }

  TextEditingController get fullnameController => _fullnameController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get emailController => _emailController;
  bool get loadActive => _loaderActive;
  Function get signupUser => _signupUser;
}
