import 'package:ecomm_mobile/models/product.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/utility/utility_extension.dart';
import 'package:ecomm_mobile/widget/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({super.key, required this.items});

  final List<Images> items;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int newIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .32,
          child: PageView.builder(
              itemCount: widget.items.length,
              onPageChanged: (int currentIndex) {
                newIndex = currentIndex;
                setState(() {});
              },
              itemBuilder: (_, index) {
                return FittedBox(
                  fit: BoxFit.none,
                  child: CustomNetworkImage(
                    imageUrl: widget.items.safeElementAt(index)?.url ?? '',
                    fit: BoxFit.contain,
                    scale: 3.0,
                  ),
                );
              }),
        ),
        AnimatedSmoothIndicator(
          activeIndex: newIndex,
          count: widget.items.length,
          effect: const WormEffect(
            dotColor: Colors.white,
            activeDotColor: AppColor.darkOrange,
          ),
        )
      ],
    );
  }
}
