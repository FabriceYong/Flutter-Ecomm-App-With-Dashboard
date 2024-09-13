class User {
  final String? sId;
  final String? name;
  final String? password;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  User(
      {this.sId,
      this.name,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sId: json['_id'],
      name: json['name'],
      password: json['password'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;

    return data;
  }
}
