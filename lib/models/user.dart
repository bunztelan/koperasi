import 'dart:convert';

class User {
  int id;
  int roleId;
  String name;
  String email;
  String status;
  String nip;
  int plantId;
  int teamId;
  String avatar;
  String maritalStatus;
  String forgotToken;
  String emailConfirmToken;
  String phoneNumber;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String role;
  String address;
  double latitude;
  double longitude;
  int addressId;
  String addressDesc;

  User({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.status,
    this.nip,
    this.plantId,
    this.teamId,
    this.avatar,
    this.maritalStatus,
    this.forgotToken,
    this.emailConfirmToken,
    this.phoneNumber,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.role,
    this.address,
    this.latitude,
    this.longitude,
    this.addressId,
    this.addressDesc,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    nip = json['nip'];
    plantId = json['plant_id'];
    teamId = json['team_id'];
    avatar = json['avatar'];
    maritalStatus = json['marital_status'];
    forgotToken = json['forgot_token'];
    emailConfirmToken = json['email_confirm_token'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    role = json['role'];
    address = jsonDecode(jsonEncode(json['address']))['street'];
    latitude = jsonDecode(jsonEncode(json['address']))['latitude'];
    longitude = jsonDecode(jsonEncode(json['address']))['longitude'];
    addressId = jsonDecode(jsonEncode(json['address']))['id'];
    addressDesc = jsonDecode(jsonEncode(json['address']))['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['nip'] = this.nip;
    data['plant_id'] = this.plantId;
    data['team_id'] = this.teamId;
    data['avatar'] = this.avatar;
    data['marital_status'] = this.maritalStatus;
    data['forgot_token'] = this.forgotToken;
    data['email_confirm_token'] = this.emailConfirmToken;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['role'] = this.role;
    return data;
  }
}
