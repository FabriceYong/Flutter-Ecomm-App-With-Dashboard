import 'package:ecomm_mobile/screens/login_screen/login_screen.dart';
import 'package:ecomm_mobile/screens/product_by_category_screen/my_order_screen/my_order_screen.dart';
import 'package:ecomm_mobile/utility/animation/open_container_wrapper.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:ecomm_mobile/widget/navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming your theme and colors are defined elsewhere in your app
    TextStyle linkStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    TextStyle titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 200,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
            ),
          ),
          const Gap(20),
          Center(
            child: Text(
              '${context.userProvider.getLoginUser()?.name}',
              style: titleStyle,
            ),
          ),
          const Gap(40),
          const OpenContainerWrapper(
            nextScreen: MyOrderScreen(),
            child: NavigationTile(
              icon: Icons.location_on,
              title: 'My Addresses',
            ),
          ),
          const Gap(20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.darkOrange,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                context.userProvider.logOutUser();
                Get.offAll(const LoginScreen());
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
