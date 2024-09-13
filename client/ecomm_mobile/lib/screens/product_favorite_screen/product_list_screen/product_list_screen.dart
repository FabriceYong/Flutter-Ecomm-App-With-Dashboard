import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/screens/product_favorite_screen/product_list_screen/components/category_selector.dart';
import 'package:ecomm_mobile/screens/product_favorite_screen/product_list_screen/components/custom_app_bar.dart';
import 'package:ecomm_mobile/screens/product_favorite_screen/product_list_screen/components/poster_section.dart';
import 'package:ecomm_mobile/widget/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Sina',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                'Lets gets something?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const PosterSection(),
              Text(
                'Top categories',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(5),
              Consumer<DataProvider>(builder: (context, dataProvider, child) {
                return CategorySelector(
                  categories: dataProvider.categories,
                );
              }),
              Consumer<DataProvider>(
                builder: (context, dataProvider, child) {
                  return ProductGridView(
                    products: dataProvider.products,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
