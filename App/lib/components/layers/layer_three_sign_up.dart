import 'package:elegant_notification/elegant_notification.dart';
import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/screens/auth/login_screen.dart';
import 'package:final_project/screens/navigation_bar_screen.dart';
import 'package:final_project/services/database/user_data.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LayerThreeSigup extends StatefulWidget {
  const LayerThreeSigup({
    super.key,
  });

  @override
  State<LayerThreeSigup> createState() => _LayerThreeSigupState();
}

bool _loading = false;
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController ConfirmpasswordController = TextEditingController();

class _LayerThreeSigupState extends State<LayerThreeSigup> {
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ConfirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    debugPrint('Token Sigup : ${supabase.auth.currentSession?.accessToken}');
    debugPrint('Token Sigup: ${supabase.auth.currentSession?.user.id}');
    return SingleChildScrollView(
      child: SizedBox(
        height: 584,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: 40,
              top: 40,
              child: TextWidget(
                  text: 'Name',
                  isBold: true,
                  size: 24,
                  fontFamily: 'Tajawal',
                  color: ETheme.colors.second.withOpacity(0.6)),
            ),
            Positioned(
                left: 40,
                top: 65,
                child: SizedBox(
                  width: 310,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Name ',
                      hintStyle: TextStyle(color: ETheme.colors.textColor),
                    ),
                  ),
                )),
            Positioned(
              left: 40,
              top: 150,
              child: TextWidget(
                  text: 'Email',
                  size: 24,
                  isBold: true,
                  fontFamily: 'Tajawal',
                  color: ETheme.colors.second.withOpacity(0.6)),
            ),
            Positioned(
                left: 40,
                top: 175,
                child: SizedBox(
                  width: 310,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(color: ETheme.colors.textColor),
                    ),
                  ),
                )),
            Positioned(
              left: 40,
              top: 250,
              child: TextWidget(
                  text: 'Password',
                  isBold: true,
                  fontFamily: 'Tajawal',
                  size: 24,
                  color: ETheme.colors.second.withOpacity(0.6)),
            ),
            Positioned(
                left: 40,
                top: 275,
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
              top: 350,
              child: TextWidget(
                  text: 'Confrim Password',
                  size: 24,
                  isBold: true,
                  fontFamily: 'Tajawal',
                  color: ETheme.colors.second.withOpacity(0.6)),
            ),
            Positioned(
                left: 40,
                top: 375,
                child: SizedBox(
                  width: 310,
                  child: TextField(
                    controller: ConfirmpasswordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(color: ETheme.colors.textColor),
                    ),
                    obscureText: true,
                  ),
                )),
            Positioned(
                left: 40,
                top: 450,
                child: SizedBox(
                  width: 320,
                  child: Button(
                    text: "Sign Up",
                    color: ETheme.colors.white,
                    onPress: () async {
                      try {
                        final name = nameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;
                        final confirmpassword = ConfirmpasswordController.text;

                        if (email.isNotEmpty &&
                            email.isValidEmail &&
                            password.isNotEmpty &&
                            name.isNotEmpty) {
                          if (password == confirmpassword) {
                            !_loading
                                ? showDialog(
                                    context: context,
                                    barrierColor:
                                        const Color.fromARGB(0, 0, 0, 0),
                                    builder: (context) => const Center(
                                            child: CircularProgressIndicator(
                                          color: primary2,
                                        )))
                                : SizedBox.shrink();
                            await SupabaseData.client.auth.signUp(
                              email: email,
                              password: password,
                            );

                            await SupabaseData.client.from('user').insert({
                              "user_id": SupabaseData
                                  .client.auth.currentSession!.user.id,
                              "name": name,
                              "email": email
                            });
                            _loading = true;
                            if (context.mounted) {
                              context.pushNav(
                                  screen: const NavigationBarScreen());
                            }
                          } else {
                            ElegantNotification.error(
                                    title: const Text("Sign up failed"),
                                    description: const Text(
                                        "Please make sure you entered a correct password"))
                                .show(context);
                          }
                        } else {
                          ElegantNotification.error(
                                  title: const Text("Sign up failed"),
                                  description: const Text(
                                      "Please make sure you entered a correct email"))
                              .show(context);
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ElegantNotification.error(
                                title: const Text("Sign up failed"),
                                description: const Text("Please try again"))
                            .show(context);
                      }
                    },
                    backgroundColor: ETheme.colors.primary.withOpacity(0.5),
                  ),
                )),
            Positioned(
              left: 40,
              top: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    text: 'Already have an account?',
                    color: ETheme.colors.second.withOpacity(0.6),
                    size: 18,
                    fontFamily: 'Tajawal',
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNav(screen: const LoginScreen());
                    },
                    child: TextWidget(
                      text: 'Log in',
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
