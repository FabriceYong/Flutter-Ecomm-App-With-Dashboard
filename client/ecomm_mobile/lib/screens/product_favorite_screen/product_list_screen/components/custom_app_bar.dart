import 'package:ecomm_mobile/models/user.dart';
import 'package:ecomm_mobile/utility/constants.dart';
import 'package:ecomm_mobile/widget/app_bar_action_button.dart';
import 'package:ecomm_mobile/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBarActionButton(
              icon: Icons.menu,
              onPressed: () {
                final box = GetStorage();
                Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
                User? userLogged = User.fromJson(userJson ?? {});
                Scaffold.of(context).openDrawer();
              },
            ),
            Expanded(
              child: CustomSearchBar(
                controller: TextEditingController(),
                onChanged: (val) {
                  //TODO: should complete call filterProducts
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
