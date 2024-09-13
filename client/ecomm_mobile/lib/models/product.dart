class Product {
  String? sId;
  String? name;
  String? description;
  int? quantity;
  double? price;
  double? offerPrice;
  ProRef? proCategoryId;
  ProRef? proSubCategoryId;
  ProRef? proBrandId;
  ProTypeRef? proVariantTypeId;
  List<String>? proVariantId;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.offerPrice,
      this.proCategoryId,
      this.proSubCategoryId,
      this.proBrandId,
      this.proVariantTypeId,
      this.proVariantId,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price']?.toDouble();
    offerPrice = json['offerPrice']?.toDouble();
    proCategoryId = json['proCategoryId'] != null
        ? ProRef.fromJson(json['proCategoryId'])
        : null;
    proSubCategoryId = json['proSubCategoryId'] != null
        ? ProRef.fromJson(json['proSubCategoryId'])
        : null;
    proBrandId =
        json['proBrandId'] != null ? ProRef.fromJson(json['proBrandId']) : null;
    proVariantTypeId = json['proVariantTypeId'] != null
        ? ProTypeRef.fromJson(json['proVariantTypeId'])
        : null;
    proVariantId = json['proVariantId'].cast<String>();
    if (json['images'] != null) {
      List<Images> images = <Images>[];
      for (var image in json['images']) {
        images.add(Images.fromJson(image));
      }
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['quantity'] = quantity;
    data['price'] = price;
    data['offerPrice'] = offerPrice;
    if (proCategoryId != null) {
      data['proCategoryId'] = proCategoryId!.toJson();
    }
    if (proSubCategoryId != null) {
      data['proSubCategory'] = proSubCategoryId!.toJson();
    }
    if (proBrandId != null) {
      data['proBrandId'] = proBrandId!.toJson();
    }
    if (proVariantTypeId != null) {
      data['proVariantTypeId'] = proVariantTypeId!.toJson();
    }
    data['proVariantId'] = proVariantId;
    if (images != null) {
      data['images'] = images!.map((image) => image.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;

    return data;
  }
}

class ProRef {
  final String? sId;
  final String? name;

  ProRef({this.sId, this.name});

  factory ProRef.fromJson(Map<String, dynamic> json) {
    return ProRef(
      sId: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;

    return data;
  }
}

class ProTypeRef {
  final String? sId;
  final String? type;

  ProTypeRef({this.sId, this.type});

  factory ProTypeRef.fromJson(Map<String, dynamic> json) {
    return ProTypeRef(sId: json['_id'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;

    return data;
  }
}

class Images {
  final int? images;
  final String? url;
  final String? sId;

  Images({this.images, this.sId, this.url});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      images: json['images'],
      url: json['url'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['url'] = url;
    data['_id'] = sId;

    return data;
  }
}
