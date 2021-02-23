import 'package:flutter/material.dart';
import 'package:nurture/styling.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Theme(
          data: ThemeData(accentColor: secondaryColor),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )),
    );
  }
}
