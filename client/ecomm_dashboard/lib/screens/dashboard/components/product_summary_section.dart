import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product_summery_info.dart';
import '../../../utility/constants.dart';
import 'product_summery_card.dart';

class ProductSummarySection extends StatelessWidget {
  const ProductSummarySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        int totalProduct = 1;
        // should complete Make this product number dynamic by calling calculateProductWithQuantity
        totalProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: null);
        int outOfStockProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: 0);
        int limitedStockProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: 1);
        int otherStockProduct =
            totalProduct - outOfStockProduct - limitedStockProduct;

        List<ProductSummaryInfo> productSummeryItems = [
          ProductSummaryInfo(
            title: "All Products",
            productsCount: totalProduct,
            svgSrc: "assets/icons/Product.svg",
            color: primaryColor,
            percentage: 100,
          ),
          ProductSummaryInfo(
            title: "Out of Stock",
            productsCount: outOfStockProduct,
            svgSrc: "assets/icons/Product2.svg",
            color: const Color(0xFFEA3829),
            percentage: totalProduct != 0
                ? (outOfStockProduct / totalProduct) * 100
                : 0,
          ),
          ProductSummaryInfo(
            title: "Limited Stock",
            productsCount: limitedStockProduct,
            svgSrc: "assets/icons/Product3.svg",
            color: const Color(0xFFECBE23),
            percentage: totalProduct != 0
                ? (limitedStockProduct / totalProduct) * 100
                : 0,
          ),
          ProductSummaryInfo(
            title: "Other Stock",
            productsCount: otherStockProduct,
            svgSrc: "assets/icons/Product4.svg",
            color: const Color(0xFF47e228),
            percentage: totalProduct != 0
                ? (otherStockProduct / totalProduct) * 100
                : 0,
          ),
        ];

        return Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productSummeryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
              ),
              itemBuilder: (context, index) => ProductSummaryCard(
                info: productSummeryItems[index],
                onTap: (productType) {
                  // should complete call filterProductsByQuantity
                  print(productType);
                  context.dataProvider
                      .filterProductsByQuantity(productType ?? '');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
