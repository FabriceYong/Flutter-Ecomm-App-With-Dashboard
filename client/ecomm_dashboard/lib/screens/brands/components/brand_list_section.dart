import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/brand.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import 'add_brand_form.dart';

class BrandListSection extends StatelessWidget {
  const BrandListSection({
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
            "All Brands",
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
                      label: Text("Brands Name"),
                    ),
                    DataColumn(
                      label: Text("Sub Category"),
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
                    dataProvider.brands.length,
                    (index) => brandDataRow(
                        dataProvider.brands[index], index + 1, edit: () {
                      showBrandForm(context, dataProvider.brands[index]);
                    }, delete: () {
                      // should complete deleteBrand
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
                                  'Are you sure you want to delete this brand?'),
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
                                    context.brandProvider.deleteBrand(
                                        dataProvider.brands[index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                )
                              ],
                            );
                          });
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

DataRow brandDataRow(Brand brandInfo, int index,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(brandInfo.name!),
            ),
          ],
        ),
      ),
      DataCell(Text(brandInfo.subcategoryId?.name ?? '')),
      DataCell(Text(brandInfo.createdAt ?? '')),
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
