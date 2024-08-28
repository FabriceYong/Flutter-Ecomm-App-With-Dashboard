import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/variant_type.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import 'add_variant_type_form.dart';

class VariantsTypeListSection extends StatelessWidget {
  const VariantsTypeListSection({
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
            "All Variants Type",
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
                      label: Text("Variant Name"),
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
                    dataProvider.variantTypes.length,
                    (index) => variantTypeDataRow(
                      dataProvider.variantTypes[index],
                      index + 1,
                      edit: () {
                        showAddVariantsTypeForm(
                            context, dataProvider.variantTypes[index]);
                      },
                      delete: () {
                        // should complete call deleteVariantType
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                buttonPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                backgroundColor: bgColor,
                                title: const Text(
                                  'Delete Variant',
                                  textAlign: TextAlign.center,
                                ),
                                content: const Text(
                                    'Are you sure you want to delete this variant type?'),
                                actions: [
                                  MaterialButton(
                                      color: secondaryColor,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                  MaterialButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              buttonPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              backgroundColor: bgColor,
                                              title: const Text(
                                                'Delete Variant',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: const Text(
                                                  'Are you sure you want to delete this variant type?'),
                                              actions: [
                                                MaterialButton(
                                                    elevation: 2,
                                                    color: secondaryColor,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                MaterialButton(
                                                  elevation: 2,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    context.variantTypeProvider
                                                        .deleteVariantType(
                                                            dataProvider
                                                                    .variantTypes[
                                                                index]);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Delete'),
                                                )
                                              ],
                                            );
                                          });

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete'),
                                  )
                                ],
                              );
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

DataRow variantTypeDataRow(VariantType VariantTypeInfo, int index,
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
              child: Text(VariantTypeInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(VariantTypeInfo.type ?? '')),
      DataCell(Text(VariantTypeInfo.createdAt ?? '')),
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
