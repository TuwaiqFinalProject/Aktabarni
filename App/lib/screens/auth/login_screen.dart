import 'package:final_project/components/layers/layer_one.dart';
import 'package:final_project/components/layers/layer_three_login.dart';
import 'package:final_project/components/layers/layer_two.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETheme.colors.primary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        // prata
        children: <Widget>[
          Positioned(
              top: 200,
              left: 40,
              child: TextWidget(
                  text: 'Welcome', size: 48, color: ETheme.colors.white)),
          Positioned(top: 290, right: 0, bottom: 0, child: LayerOne()),
          Positioned(top: 318, left: 20, bottom: 0, child: LayerTwo()),
          const Positioned(
              top: 320, right: 0, bottom: 0, child: LayerThreeLogin()),
        ],
      ),
    );
  }
}
