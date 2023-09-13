import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/general/room_card_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
          child: GlassCard(
              child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                kVSpace8,
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Button(
                    text: 'Join',
                    backgroundColor: ETheme.colors.primary,
                    onPress: () {},
                    borderRadius: 35,
                    btnHigth: 10,
                    textSize: 15,
                    color: Colors.white,
                  ),
                ])
              ])),
          SizedBox(
            height: context.getHeight - 200,
            child: ListView(padding: EdgeInsets.zero, children: [
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const RoomCard(
                      roomName: 'room name',
                      numOfMembers: 3,
                      userOwner: 'owner name',
                      description: 'description',
                    );
                  }),
            ]),
          ),
          kVSpace128
        ],
      ))),
    );
  }
}
