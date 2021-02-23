import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurture/provider_forgot_password.dart';
import 'package:nurture/provider_login.dart';
import 'package:nurture/provider_signup.dart';
import 'package:nurture/screen_landing.dart';
import 'package:nurture/screen_login.dart';
import 'package:nurture/styling.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginBloc()),
        ChangeNotifierProvider(create: (_) => SignupBloc()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordBloc()),
      ],
      child: MaterialApp(
        title: 'Nurture Africa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingScreen(),
      ),
    );
  }
}
