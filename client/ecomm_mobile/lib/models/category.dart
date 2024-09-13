class Category {
  final String? sId;
  final String? name;
  final String? image;
  final bool isSelected;
  final String? createdAt;
  final String? updatedAt;

  Category(
      {this.sId,
      this.name,
      this.image,
      this.isSelected = false,
      this.createdAt,
      this.updatedAt});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        sId: json['_id'],
        name: json['name'],
        image: json['image'],
        isSelected: false,
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    // data['isSelected'] = isSelected;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}
