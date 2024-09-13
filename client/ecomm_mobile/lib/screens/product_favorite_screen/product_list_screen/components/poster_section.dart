import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/utility/app_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PosterSection extends StatelessWidget {
  const PosterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: dataProvider.posters.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppData.randomPosterColors[index],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${dataProvider.posters[index].name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const Gap(8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Get Now',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Image.network(
                        '${dataProvider.posters[index].imageUrl}',
                        height: 125,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null, // Progress indicator
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
