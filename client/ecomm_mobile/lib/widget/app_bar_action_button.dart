import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton(
      {super.key, required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightGrey,
      ),
      child: IconButton(
          onPressed: onPressed,
          constraints: const BoxConstraints(),
          icon: Icon(
            icon,
            color: Colors.black,
          )),
    );
  }
}
