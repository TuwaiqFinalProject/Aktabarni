import 'package:final_project/app.dart';
import 'package:final_project/components/button/rouller_button.dart';
import 'package:final_project/components/general/custom_option_account.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/services/database/user_data.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool testReminderSwitchValue = false;
  bool chatMessagesSwitchValue = false;
  bool notificationSwitchValue = false; // New switch value for the third button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ETheme.colors.backgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: ETheme.colors.primary,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            kVSpace8,
            const TextWidget(
              text: 'Settings',
              color: Colors.black,
              isBold: true,
              size: 24,
            ),
            kVSpace64,
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: ETheme.colors.primary,
                ),
                kHSpace8,
                const TextWidget(
                  text: 'Account',
                  size: 18,
                  color: Colors.black,
                  isBold: true,
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const Rowbuild(
              title: 'Change Password',
              color: Colors.black,
            ),
            const Rowbuild(title: 'Social', color: Colors.black),
            const Rowbuild(title: 'Language', color: Colors.black),
            const Rowbuild(title: 'Social', color: Colors.black),
            kVSpace64,
            Row(
              children: [
                Icon(
                  Icons.volume_up,
                  size: 30,
                  color: ETheme.colors.primary,
                ),
                kHSpace8,
                const TextWidget(
                  text: 'Notifications',
                  size: 18,
                  color: Colors.black,
                  isBold: true,
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            kVSpace8,
            RollerButton(
              title: 'Test Reminder',
              switchValue: testReminderSwitchValue,
              onChanged: (bool value) {
                setState(() {
                  testReminderSwitchValue = value;
                });
              },
            ),
            RollerButton(
              title: 'Chat messages',
              switchValue: chatMessagesSwitchValue,
              onChanged: (bool value) {
                setState(() {
                  chatMessagesSwitchValue = value;
                });
              },
            ),
            RollerButton(
              title: 'Theme', // Third button title
              switchValue: notificationSwitchValue, // Third button switch value
              onChanged: (bool value) {
                //   contect.read<ThemeCubit>().changeThem()
                setState(() {
                  notificationSwitchValue = value;
                });
              },
            ),
            kVSpace24,
            Center(
              child: TextButton(
                onPressed: () {
                  SupabaseData.client.auth.signOut();
                  context.pushAndRemoveNav(screen: const App());
                },
                child: const TextWidget(
                  text: 'Sing out',
                  color: Colors.red,
                  isBold: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
