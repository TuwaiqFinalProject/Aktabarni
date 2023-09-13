import 'package:final_project/components/layers/layer_one.dart';
import 'package:final_project/components/layers/layer_three_sign_up.dart';
import 'package:final_project/components/layers/layer_two.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETheme.colors.primary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              top: 70,
              left: 40,
              child: TextWidget(
                  text: 'Sign Up', size: 35, color: ETheme.colors.white)),
          Positioned(top: 150, right: 0, bottom: 0, child: LayerOne()),
          Positioned(top: 180, left: 20, bottom: 0, child: LayerTwo()),
          const Positioned(
              top: 190, right: 0, bottom: 0, child: LayerThreeSigup()),
        ],
      ),
    );
  }
}
