import 'package:ecomm_dashboard/utility/delete_dialog.dart';
import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import '../../../utility/constants.dart';
import 'add_product_form.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Products",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: const [
                    DataColumn(
                      label: Text("Product Name"),
                    ),
                    DataColumn(
                      label: Text("Category"),
                    ),
                    DataColumn(
                      label: Text("Sub Category"),
                    ),
                    DataColumn(
                      label: Text("Price"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.products.length,
                    (index) => productDataRow(
                      dataProvider.products[index],
                      edit: () {
                        showAddProductForm(
                            context, dataProvider.products[index]);
                      },
                      delete: () {
                        // should complete call deleteProduct
                        showDeleteDialog(
                            title: 'Delete',
                            content: const Text(
                                'Are you sure you want to delete this product?'),
                            onPressed: () {
                              context.dashBoardProvider
                                  .deleteProduct(dataProvider.products[index]);
                            });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productDataRow(Product productInfo,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              productInfo.images?.first.url ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(productInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(productInfo.proCategoryId?.name ?? '')),
      DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
      DataCell(
        Text('${productInfo.price}'),
      ),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
