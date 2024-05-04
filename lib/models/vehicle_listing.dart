import 'dart:convert';

import 'package:someonetoview/models/location.dart';

class VehicleListing {
  final String id;
  final String mainImageUrl;
  final String title;
  final int price;
  final Location location;
  final String description;
  final int mileage;
  final List<String> imageUrls;

  VehicleListing({
    required this.id,
    required this.mainImageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.mileage,
    required this.imageUrls,
  });

  VehicleListing copyWith({
    String? id,
    String? mainImageUrl,
    String? title,
    int? price,
    Location? location,
    String? description,
    int? mileage,
    List<String>? imageUrls,
  }) =>
      VehicleListing(
        id: id ?? this.id,
        mainImageUrl: mainImageUrl ?? this.mainImageUrl,
        title: title ?? this.title,
        price: price ?? this.price,
        location: location ?? this.location,
        description: description ?? this.description,
        mileage: mileage ?? this.mileage,
        imageUrls: imageUrls ?? this.imageUrls,
      );

  factory VehicleListing.fromJson(String str) =>
      VehicleListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleListing.fromMap(Map<String, dynamic> json) => VehicleListing(
        id: json['id'],
        mainImageUrl: json['main_image_url'],
        title: json['title'],
        price: json['price'],
        location: Location.fromMap(json['location']),
        description: json['description'],
        mileage: json['mileage'],
        imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'main_image_url': mainImageUrl,
        'title': title,
        'price': price,
        'location': location.toMap(),
        'description': description,
        'mileage': mileage,
        'image_urls': List<dynamic>.from(imageUrls.map((x) => x)),
      };
}
