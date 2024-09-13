import 'package:ecomm_mobile/screens/product_favorite_screen/provider/favorite_provider.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/widget/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      // TODO: should complete call loadFovoriteItems
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.darkOrange,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
          return ProductGridView(
            products: favoriteProvider.favoriteProducts,
          );
        }),
      ),
    );
  }
}
