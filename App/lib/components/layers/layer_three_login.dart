// ignore_for_file: use_build_context_synchronously

import 'package:elegant_notification/elegant_notification.dart';
import 'package:final_project/app.dart';
import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/screens/auth/sign_up_screen.dart';
import 'package:final_project/services/database/user_data.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/validation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LayerThreeLogin extends StatefulWidget {
  const LayerThreeLogin({
    super.key,
  });

  @override
  State<LayerThreeLogin> createState() => _LayerThreeLoginState();
}

bool _loading = false;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LayerThreeLoginState extends State<LayerThreeLogin> {
  @override
  Widget build(BuildContext context) {
    final supabase1 = Supabase.instance.client;
    print('Token: ${supabase1.auth.currentSession?.accessToken}');
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: 584,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: 40,
              top: 40,
              child: TextWidget(
                text: 'Email',
                size: 24,
                color: ETheme.colors.second.withOpacity(0.6),
                isBold: true,
                fontFamily: 'Tajawal',
              ),
            ),
            Positioned(
                left: 40,
                top: 65,
                child: SizedBox(
                  width: 310,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Email ',
                      hintStyle: TextStyle(color: ETheme.colors.textColor),
                    ),
                  ),
                )),
            Positioned(
                left: 40,
                top: 150,
                child: TextWidget(
                  text: 'Password',
                  size: 24,
                  color: ETheme.colors.second.withOpacity(0.6),
                  isBold: true,
                  fontFamily: 'Tajawal',
                )),
            Positioned(
                left: 40,
                top: 175,
                child: SizedBox(
                  width: 310,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(color: ETheme.colors.textColor),
                    ),
                    obscureText: true,
                  ),
                )),
            Positioned(
                left: 40,
                top: 250,
                child: SizedBox(
                  width: 320,
                  child: Button(
                    text: "Login",
                    color: ETheme.colors.white,
                    onPress: () async {
                      _loading = true;
                      try {
                        final email = emailController.text;
                        final password = passwordController.text;
                        if (email.isNotEmpty &&
                            password.isNotEmpty &&
                            email.isValidEmail) {
                          _loading
                              ? showDialog(
                                  context: context,
                                  barrierColor:
                                      const Color.fromARGB(0, 0, 0, 0),
                                  builder: (context) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: primary2,
                                    ));
                                  })
                              : SizedBox.shrink();

                          await SupabaseData.client.auth.signInWithPassword(
                            email: email,
                            password: password,
                          );
                          if (_loading) {
                            Navigator.pop(context);
                          }
                          _loading = false;
                          if (context.mounted) {
                            context.pushNav(screen: const App());
                          }
                        } else {
                          print("------------");
                          if (_loading) {
                            Navigator.pop(context);
                          }
                          _loading = false;
                          ElegantNotification.error(
                                  title: const Text("Login failed"),
                                  description: const Text(
                                      "Please make sure you entered correct email"))
                              .show(context);
                        }
                      } catch (e) {
                        print("-------catch-----");
                        if (_loading) {
                          Navigator.pop(context);
                        }
                        _loading = false;
                        setState(() {});
                        ElegantNotification.error(
                                title: const Text("Login failed"),
                                description: const Text("Please try again"))
                            .show(context);
                      }
                    },
                    backgroundColor: ETheme.colors.primary.withOpacity(0.5),
                  ),
                )),
            Positioned(
              left: 40,
              top: 310,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                      text: 'Dont have an account?',
                      size: 18,
                      fontFamily: 'Tajawal',
                      color: ETheme.colors.second.withOpacity(0.6)),
                  TextButton(
                    onPressed: () {
                      context.pushNav(screen: const SignUpScreen());
                    },
                    child: TextWidget(
                      text: 'Sign up',
                      color: ETheme.colors.second,
                      size: 18,
                      isBold: true,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
