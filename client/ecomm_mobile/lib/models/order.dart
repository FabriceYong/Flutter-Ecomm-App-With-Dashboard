class Order {
  ShippingAddress? shippingAddress;
  OrderTotal? orderTotal;
  String? sId;
  UserID? userID;
  String? orderStatus;
  List<Items>? items;
  double? totalPrice;
  String? paymentMethod;
  CouponCode? couponCode;
  String? trackingUrl;
  String? orderDate;
  int? iV;

  Order(
      {this.shippingAddress,
      this.orderTotal,
      this.sId,
      this.userID,
      this.orderStatus,
      this.items,
      this.totalPrice,
      this.paymentMethod,
      this.couponCode,
      this.trackingUrl,
      this.orderDate,
      this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    orderTotal = json['orderTotal'] != null
        ? OrderTotal.fromJson(json['orderTotal'])
        : null;
    sId = json['_id'];
    userID = json['userID'] != null ? UserID.fromJson(json['userID']) : null;
    orderStatus = json['orderStatus'];
    if (json['items'] != null) {
      List<Items> items = <Items>[];
      json['items'].forEach((item) {
        items.add(Items.fromJson(item));
      });
    }
    totalPrice = json['totalPrice']?.toDouble();
    paymentMethod = json['paymentMethod'];
    couponCode = json['couponCode'] != null
        ? CouponCode.fromJson(json['couponCode'])
        : null;
    trackingUrl = json['trackingUrl'];
    orderDate = json['orderDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (data['shippingAddress'] != null) {
      data['shippingAddress'] = shippingAddress?.toJson();
    }
    if (data['orderTotal'] != null) {
      data['orderTotal'] = orderTotal?.toJson();
    }
    data['_id'] = sId;
    if (data['userID'] != null) {
      data['userID'] = userID?.toJson();
    }
    data['orderStatus'] = orderStatus;
    data['totalPrice'] = totalPrice;
    data['paymentMethod'] = paymentMethod;
    if (data['couponCode'] != null) {
      data['couponCode'] = couponCode?.toJson();
    }
    data['trackingUrl'] = trackingUrl;
    data['orderDate'] = orderDate;
    data['__v'] = iV;

    return data;
  }
}

class ShippingAddress {
  final String? phone;
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  ShippingAddress(
      {this.phone,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.country});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
        phone: json['phone'],
        street: json['stree'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    data['country'] = country;

    return data;
  }
}

class OrderTotal {
  final double? subTotal;
  final double? discount;
  final double? total;

  OrderTotal({this.subTotal, this.discount, this.total});

  factory OrderTotal.fromJson(Map<String, dynamic> json) {
    return OrderTotal(
        subTotal: json['subTotal']?.toDouble(),
        discount: json['discount']?.toDouble(),
        total: json['total']?.toDouble());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotal'] = subTotal;
    data['discount'] = discount;
    data['total'] = total;

    return data;
  }
}

class UserID {
  final String? id;
  final String? name;

  UserID({this.id, this.name});

  factory UserID.fromJson(Map<String, dynamic> json) {
    return UserID(id: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;

    return data;
  }
}

class CouponCode {
  final String? sId;
  final String? discountType;
  final int? discountAmount;
  final String? couponCode;

  CouponCode(
      {this.sId, this.discountType, this.discountAmount, this.couponCode});

  factory CouponCode.fromJson(Map<String, dynamic> json) {
    return CouponCode(
      sId: json['_id'],
      discountAmount: json['discountAmount'],
      discountType: json['discountType'],
      couponCode: json['couponCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['discountAmount'] = discountAmount;
    data['discountType'] = discountType;
    data['couponCode'] = couponCode;

    return data;
  }
}

class Items {
  final String? productId;
  final String? productName;
  final int? quantity;
  final double? price;
  final String? variant;
  final String? sId;

  Items(
      {this.productId,
      this.productName,
      this.quantity,
      this.price,
      this.variant,
      this.sId});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price']?.toDouble(),
      variant: json['variant'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['variant'] = variant;
    data['_id'] = sId;

    return data;
  }
}
