import 'package:ecomm_dashboard/utility/delete_dialog.dart';
import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/variant.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import 'add_variant_form.dart';

class VariantsListSection extends StatelessWidget {
  const VariantsListSection({
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
            "All Variants",
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
                      label: Text("Variant"),
                    ),
                    DataColumn(
                      label: Text("Variant Type"),
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
                    dataProvider.variants.length,
                    (index) => variantDataRow(
                        dataProvider.variants[index], index + 1, edit: () {
                      showAddVariantForm(context, dataProvider.variants[index]);
                    }, delete: () {
                      // should complete call deleteVariant
                      showDeleteDialog(
                          title: 'Delete',
                          content: const Text(
                              'Are you sure you want to delete this variant?'),
                          onPressed: () {
                            context.variantProvider
                                .deleteVariant(dataProvider.variants[index]);
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

DataRow variantDataRow(Variant VariantInfo, int index,
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
              child: Text(VariantInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(VariantInfo.variantTypeId?.name ?? '')),
      DataCell(Text(VariantInfo.createdAt ?? '')),
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
