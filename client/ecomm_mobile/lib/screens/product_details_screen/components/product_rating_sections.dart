import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductRatingSections extends StatelessWidget {
  const ProductRatingSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: 3.2,
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {},
        ),
        Text(
          '(4500 reviews)',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
