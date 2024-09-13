import 'dart:ui' show PointerDeviceKind;

import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/models/user.dart';
import 'package:ecomm_mobile/screens/home_screen.dart';
import 'package:ecomm_mobile/screens/login_screen/login_screen.dart';
import 'package:ecomm_mobile/screens/login_screen/provider/user_provider.dart';
import 'package:ecomm_mobile/screens/product_by_category_screen/provider/product_by_category_provider.dart';
import 'package:ecomm_mobile/screens/product_cart_screen/provider/cart_provider.dart';
import 'package:ecomm_mobile/screens/product_details_screen/provider/provider.dart';
import 'package:ecomm_mobile/screens/product_favorite_screen/provider/favorite_provider.dart';
import 'package:ecomm_mobile/screens/profile_screen/provider/profile_provider.dart';
import 'package:ecomm_mobile/utility/app_theme.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var cart = FlutterCart();
  // TODO: should comlete add one signal app id
  OneSignal.initialize('YOUR_ONE_SIGNAL_APP_ID');
  OneSignal.Notifications.requestPermission(true);
  await cart.initializeCart(isPersistenceSupportEnabled: true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(
            create: (context) => UserProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => ProfileProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) =>
                ProductByCategoryProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => ProductDetailsProvider(context.dataProvider)),
        ChangeNotifierProvider(
            create: (context) => CartProvider(context.userProvider)),
        ChangeNotifierProvider(
            create: (context) => FavoriteProvider(context.dataProvider))
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? loginUser = context.userProvider.getLoginUser();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        }),
        home: loginUser?.sId != null ? const LoginScreen() : const HomeScreen(),
        theme: AppTheme.lightMode);
  }
}
