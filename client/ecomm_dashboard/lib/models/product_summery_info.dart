import 'dart:ui';

class ProductSummaryInfo {
  final String? svgSrc, title;
  final int? productsCount;
  final double? percentage;
  final Color? color;

  ProductSummaryInfo({
    this.svgSrc,
    this.title,
    this.productsCount,
    this.percentage,
    this.color,
  });
}
