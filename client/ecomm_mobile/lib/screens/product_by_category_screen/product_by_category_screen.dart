import 'package:ecomm_mobile/models/brand.dart';
import 'package:ecomm_mobile/models/category.dart';
import 'package:ecomm_mobile/models/sub_category.dart';
import 'package:ecomm_mobile/screens/product_by_category_screen/provider/product_by_category_provider.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/widget/custom_dropdown.dart';
import 'package:ecomm_mobile/widget/horizontal_list.dart';
import 'package:ecomm_mobile/widget/multi_select_drop_down.dart';
import 'package:ecomm_mobile/widget/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductByCategoryScreen extends StatelessWidget {
  const ProductByCategoryScreen({super.key, required this.selectedCategory});
  final Category selectedCategory;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      // TODO: should complete call filterInitialProductAndSubCategory
    });
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text(
                '${selectedCategory.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkOrange,
                ),
              ),
              expandedHeight: 190.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  var top = constraints.biggest.height -
                      MediaQuery.of(context).padding.top;
                  return Stack(
                    children: [
                      Positioned(
                        top: top - 145,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Consumer<ProductByCategoryProvider>(
                                builder: (context, proByCatProvider, child) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: HorizontalList(
                                    items: proByCatProvider.subCategories,
                                    selected:
                                        proByCatProvider.mySelectedSubCategory,
                                    itemToString: (SubCategory? subCategory) =>
                                        subCategory?.name ?? '',
                                    onSelect: (value) {
                                      // TODO: should complete call filterProductByCategory
                                    }),
                              );
                            }),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown<String>(
                                    hintText: 'Sort By Price',
                                    items: const ['Low To High', 'High To Low'],
                                    onChanged: (value) {
                                      if (value?.toLowerCase() ==
                                          'low to high') {
                                        // TODO: should complete call sortProducts(ascending: true)
                                      } else {
                                        //TODO: should complete call sortProducts(ascending: false)
                                      }
                                    },
                                    displayItem: (value) => value,
                                  ),
                                ),
                                Expanded(
                                  child: Consumer<ProductByCategoryProvider>(
                                    builder: (context, proByCategoryProvider,
                                        child) {
                                      return MultiSelectDropDown<Brand>(
                                        hintText: 'Filter By Brands',
                                        items: proByCategoryProvider.brands,
                                        onSelectionChanged: (value) {
                                          proByCategoryProvider.selectedBrands =
                                              value;
                                          // TODO: should complete call filterProductByBrand
                                          proByCategoryProvider.updateUI();
                                        },
                                        displayItem: (value) =>
                                            value.name ?? '',
                                        selectedItems: proByCategoryProvider
                                            .selectedBrands,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Consumer<ProductByCategoryProvider>(
                  builder: (context, proByCatProvider, child) {
                    return ProductGridView(
                      products: proByCatProvider.filteredProducts,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
