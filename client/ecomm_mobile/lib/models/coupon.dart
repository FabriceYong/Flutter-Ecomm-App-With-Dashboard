class Coupon {
  final String? sId;
  final String? couponCode;
  final String? discountType;
  final double? discountAmount;
  final double? minimumPurchaseAmount;
  final String? endDate;
  final String? status;
  final String? applicableCategory;
  final Null applicableSubCategory;
  final Null applicableProduct;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  Coupon(
      {this.sId,
      this.couponCode,
      this.discountType,
      this.discountAmount,
      this.minimumPurchaseAmount,
      this.applicableCategory,
      this.applicableProduct,
      this.applicableSubCategory,
      this.createdAt,
      this.updatedAt,
      this.endDate,
      this.status,
      this.iV});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      sId: json['_id'],
      couponCode: json['couponCode'],
      discountType: json['discountType'],
      discountAmount: json['discountAmount'].toDouble(),
      minimumPurchaseAmount: json['minimumPurchaseAmount'].toDouble(),
      endDate: json['endDate'],
      status: json['status'],
      applicableCategory: json['applicableCategory'],
      applicableSubCategory: json['applicableSubCategory'],
      applicableProduct: json['applicableProduct'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['couponCode'] = couponCode;
    data['discountType'] = discountType;
    data['discountAmount'] = discountAmount;
    data['minimumPurchaseAmount'] = minimumPurchaseAmount;
    data['endDate'] = endDate;
    data['status'] = status;
    data['applicableCategory'] = applicableCategory;
    data['applicableSubCategory'] = applicableSubCategory;
    data['applicableProduct'] = applicableProduct;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;

    return data;
  }
}
