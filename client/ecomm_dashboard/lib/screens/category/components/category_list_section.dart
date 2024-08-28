import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../utility/constants.dart';
import 'add_category_form.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({
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
            "All Categories",
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
                      label: Text("Category Name"),
                    ),
                    DataColumn(
                      label: Text("Added Date"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.categories.length,
                    (index) => categoryDataRow(dataProvider.categories[index],
                        delete: () {
                          showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              buttonPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              backgroundColor: bgColor,
                              title: const Text(
                                'Delete Variant',
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                  'Are you sure you want to delete this sub category?'),
                              actions: [
                                MaterialButton(
                                    elevation: 2,
                                    color: secondaryColor,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel')),
                                MaterialButton(
                                  elevation: 2,
                                  color: Colors.red,
                                  onPressed: () {
                                           context.categoryProvider
                          .deleteCategory(dataProvider.categories[index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                )
                              ],
                            );
                          });
               
                    }, edit: () {
                      showAddCategoryForm(
                          context, dataProvider.categories[index]);
                    }),
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

DataRow categoryDataRow(Category CatInfo, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              CatInfo.image ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(CatInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(CatInfo.createdAt ?? '')),
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
