import 'package:flutter/material.dart';

extension NavigatorExten on BuildContext {
  pushNav({required Widget screen}) {
    return Navigator.push(
        this, MaterialPageRoute(builder: (context) => screen));
  }


  popNav() {
    return Navigator.of(this).pop();
  }

  pushAndRemoveNav({required Widget screen}) {
    return Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}
