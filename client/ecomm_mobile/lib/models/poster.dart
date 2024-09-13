class Poster {
  final String? sId;
  final String? name;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  Poster({this.sId, this.name, this.imageUrl, this.createdAt, this.updatedAt, this.iV});

  factory Poster.fromJson(Map<String, dynamic> json){
    return Poster(
      sId: json['_id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;

    return data;
  }
}