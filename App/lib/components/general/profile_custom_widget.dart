import 'package:final_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

class ProfileCustomWidget extends StatelessWidget {
  const ProfileCustomWidget({
    Key? key,
    required this.title,
    this.textsize,
    this.color,
    this.borderRadius,
    this.icon,
    this.onPress,
    this.bold,
  }) : super(key: key);

  final String title;
  final double? textsize;
  final Color? color;
  final double? borderRadius;
  final Icon? icon;
  final bool? bold;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ETheme.colors.primary.withOpacity(1),
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: textsize,
          fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ETheme.colors.primary.withOpacity(1),
        ),
        child: Icon(
          LineAwesomeIcons.angle_right,
          color: color,
        ),
      ),
    );
  }
}
