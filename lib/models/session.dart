class Session {
  int userId;
  String firebaseRegId;
  String accessToken;
  bool isActive;
  Null deletedAt;
  int id;
  String createdAt;
  String updatedAt;

  Session(
      {this.userId,
        this.firebaseRegId,
        this.accessToken,
        this.isActive,
        this.deletedAt,
        this.id,
        this.createdAt,
        this.updatedAt});

  Session.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firebaseRegId = json['firebase_reg_id'];
    accessToken = json['access_token'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['firebase_reg_id'] = this.firebaseRegId;
    data['access_token'] = this.accessToken;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}