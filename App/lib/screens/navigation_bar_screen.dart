import 'package:button_navigation_bar/button_navigation_bar.dart';
import 'package:button_navigation_bar/button_navigation_expandable.dart';
import 'package:final_project/screens/calender_screen.dart';
import 'package:final_project/screens/create_exam_screen.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/profile/profile_screen.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  final List<Widget> pages = [const Home(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[selectedPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Container(
            child: Theme(
              data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: ETheme.colors.second,
                    ),
              ),
              child: Positioned(
                bottom: 20,
                width: context.getWidth,
                child: ButtonNavigationBar(
                  spaceBetweenItems: 0,
                  children: [
                    ButtonNavigationItem(
                        width: context.getWidth / 2 - 50,
                        color: ETheme.colors.second,
                        icon: const Icon(Icons.home),
                        onPressed: () {
                          setState(() {
                            selectedPageIndex = 0;
                          });
                        }),
                    ButtonNavigationItem.expandable(
                        color: ETheme.colors.second,
                        expandableSpacing: 48.0,
                        verticalOffset: 56.0,
                        icon: const Icon(Icons.add),
                        collapseButton: ButtonNavigationItem(
                            onPressed: () {},
                            color: const Color.fromARGB(255, 103, 113, 157),
                            icon: const Icon(Icons.close)),
                        children: [
                          ButtonNavigationExpandable(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            onPressed: () {
                              context.pushNav(screen: const CalenderScreen());
                            },
                            height: 40,
                            width: 165,
                            label: "Calender",
                            icon: const Icon(Icons.calendar_today_outlined),
                          ),
                          ButtonNavigationExpandable(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            onPressed: () {
                              context.pushNav(screen: const CreateExam());
                            },
                            height: 40,
                            width: 165,
                            label: "Create Exame",
                            icon: const Icon(Icons.my_library_books_sharp),
                          ),
                        ]),
                    ButtonNavigationItem(
                        width: context.getWidth / 2 - 50,
                        color: ETheme.colors.second,
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          setState(() {
                            selectedPageIndex = 1;
                          });
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
