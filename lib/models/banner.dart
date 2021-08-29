import 'dart:convert';

class BannerModel {
  int id;
  String name;
  String imageId;
  String image;
  bool status;
  String bannerLink;

  BannerModel({
    this.id = 0,
    this.name = '',
    this.imageId = '',
    this.image = '',
    this.status = false,
    this.bannerLink = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageId': imageId,
      'image': 'image',
      'status': status,
      'bannerLink': bannerLink,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'],
      name: map['name'],
      imageId: map['image_id'],
      image: map['image'],
      status: map['status'],
      bannerLink: map['banner_link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));
}
