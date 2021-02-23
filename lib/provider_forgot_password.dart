import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nurture/global_content.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordBloc with ChangeNotifier {
  TextEditingController _userEmailController;
  TextEditingController _newPasswordController;
  TextEditingController _confirmPasswordController;
  bool _loaderActive = false;
  bool _emailExists = false;

  ForgotPasswordBloc() {
    _userEmailController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  _clearControllers() {
    _userEmailController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  _submitUserEmail(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    _loaderActive = true;
    notifyListeners();

    if (validateText(_userEmailController.text)) {
      final response = await http.post("$apiMainUrl/nurtureCheckAccount.php",
          body: {"email": _userEmailController.text});

      _loaderActive = false;
      notifyListeners();

      if (response.statusCode == 200) {
        var message = json.decode(response.body);

        if (message[0]['valid'] == "TRUE") {
          _emailExists = true;
          notifyListeners();
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Email Does Not Exist!"),
          ));
        }
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please Check Your Internet Connection!"),
        ));
      }
    }
  }

  _changePassword(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) async {
    _loaderActive = true;
    notifyListeners();

    if (validateText(_newPasswordController.text) &&
        validateText(_confirmPasswordController.text)) {
      if (_confirmPasswordController.text == _newPasswordController.text) {
        final response =
            await http.post("$apiMainUrl/nurtureChangePassword.php", body: {
          "email": _userEmailController.text,
          "password": _confirmPasswordController.text,
        });

        _loaderActive = false;
        notifyListeners();

        if (response.statusCode == 200) {
          var message = json.decode(response.body);
          _clearControllers();
          if (message['REGISTERED'] == "SUCCESSFUL") {
            Navigator.of(context).pop();
          } else {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Check Your Internet Connection"),
            ));
          }
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Check Your Internet Connection"),
          ));
        }
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Passwords Are Not The Same"),
        ));
      }
    } else {
      _loaderActive = false;
      notifyListeners();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Fill In All The Form Fields"),
      ));
    }
  }

  TextEditingController get usernameController => _userEmailController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  bool get loadActive => _loaderActive;
  bool get emailExists => _emailExists;
  Function get submitUserEmail => _submitUserEmail;
  Function get changePassword => _changePassword;
}
