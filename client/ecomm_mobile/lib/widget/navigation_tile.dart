import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NavigationTile extends StatelessWidget {
  const NavigationTile({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.darkOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const Gap(20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: Colors.black87),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
