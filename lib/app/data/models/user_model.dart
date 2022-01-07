class UserModel {
  String? uid;
  String? email;
  String? name;
  String? photoUrl;
  String? status;
  String? lastSignin;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.photoUrl,
      this.status,
      this.lastSignin,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    lastSignin = json['lastSignin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['lastSignin'] = lastSignin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
