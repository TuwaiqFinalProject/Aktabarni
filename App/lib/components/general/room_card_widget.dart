import 'package:final_project/components/general/image_room_widget.dart';

import 'package:final_project/utils/constants/colors.dart';

import 'package:final_project/functions/border_radius_fun.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  const RoomCard(
      {super.key,
      required this.roomName,
      required this.description,
      required this.userOwner,
      required this.numOfMembers,
      this.imageURL = 'assets/bg.jpg'});
  final String roomName;
  final String description;
  final String userOwner;
  final int numOfMembers;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: context.getWidth - 80,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('room name'),
                ],
              ),
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: borderFun(),
                  child: ImageWidget(
                    path: imageURL,
                    height: 150,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: context.getWidth - 80,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ETheme.colors.white,
                        borderRadius: borderFun(),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('description'),
                          Text('user name: Owner'),
                        ],
                      )),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.groups_rounded)),
                ),
                const Positioned(bottom: 30, right: 12, child: Text('5')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
