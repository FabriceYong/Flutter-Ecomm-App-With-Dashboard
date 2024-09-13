class Brand {
  final String? sId;
  final String? name;
  final SubCategoryId? subCategoryId;
  final String? createdAt;
  final String? updatedAt;

  Brand(
      {this.sId,
      this.name,
      this.subCategoryId,
      this.createdAt,
      this.updatedAt});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      sId: json['sId'],
      name: json['name'],
      subCategoryId: json['subCategoryId'] != null
          ? SubCategoryId.fromJson(json['subCategoryId'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (data['subCategoryId'] != null) {
      data['subCategoryId'] = subCategoryId!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SubCategoryId {
  final String? sId;
  final String? name;
  final String? categoryId;
  final String? createdAt;
  final String? updatedAt;

  SubCategoryId(
      {this.sId, this.name, this.categoryId, this.createdAt, this.updatedAt});

  factory SubCategoryId.fromJson(Map<String, dynamic> json) {
    return SubCategoryId(
        sId: json['_id'],
        name: json['name'],
        categoryId: json['categoryId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['categoryId'] = categoryId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
