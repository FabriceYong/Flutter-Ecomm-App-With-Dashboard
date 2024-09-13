import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/screens/login_screen/provider/user_provider.dart';
import 'package:ecomm_mobile/screens/product_by_category_screen/provider/product_by_category_provider.dart';
import 'package:ecomm_mobile/screens/product_cart_screen/provider/cart_provider.dart';
import 'package:ecomm_mobile/screens/product_details_screen/provider/provider.dart';
import 'package:ecomm_mobile/screens/product_favorite_screen/provider/favorite_provider.dart';
import 'package:ecomm_mobile/screens/profile_screen/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension Providers on BuildContext {
  DataProvider get dataProvider =>
      Provider.of<DataProvider>(this, listen: false);
  ProductByCategoryProvider get proByCatProvider =>
      Provider.of<ProductByCategoryProvider>(this, listen: false);
  ProductDetailsProvider get proDetailProvider =>
      Provider.of<ProductDetailsProvider>(this, listen: false);
  CartProvider get cartProvider =>
      Provider.of<CartProvider>(this, listen: false);
  FavoriteProvider get favoriteProvider =>
      Provider.of<FavoriteProvider>(this, listen: false);
  UserProvider get userProvider =>
      Provider.of<UserProvider>(this, listen: false);
  ProfileProvider get profileProvider =>
      Provider.of<ProfileProvider>(this, listen: false);
}
