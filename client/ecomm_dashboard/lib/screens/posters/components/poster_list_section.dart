import 'package:ecomm_dashboard/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/poster.dart';
import '../../../utility/constants.dart';
import 'add_poster_form.dart';

class PosterListSection extends StatelessWidget {
  const PosterListSection({
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
            "All Posters",
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
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.posters.length,
                    (index) =>
                        posterDataRow(dataProvider.posters[index], delete: () {
                      // should complete call deletePoster
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
                                  'Are you sure you want to delete this poster?'),
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
                                    context.posterProvider.deletePoster(
                                        dataProvider.posters[index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                )
                              ],
                            );
                          });
                    }, edit: () {
                      showAddPosterForm(context, dataProvider.posters[index]);
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

DataRow posterDataRow(Poster poster, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              poster.imageUrl ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(poster.posterName ?? ''),
            ),
          ],
        ),
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
