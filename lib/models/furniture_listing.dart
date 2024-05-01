import 'dart:convert';

import 'package:someonetoview/models/location.dart';

class FurnitureListing {
  final String id;
  final String mainImageUrl;
  final String title;
  final int price;
  final Location location;
  final String description;
  final String condition;
  final List<String> imageUrls;

  FurnitureListing({
    required this.id,
    required this.mainImageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.condition,
    required this.imageUrls,
  });

  FurnitureListing copyWith({
    String? id,
    String? mainImageUrl,
    String? title,
    int? price,
    Location? location,
    String? description,
    String? condition,
    List<String>? imageUrls,
  }) =>
      FurnitureListing(
        id: id ?? this.id,
        mainImageUrl: mainImageUrl ?? this.mainImageUrl,
        title: title ?? this.title,
        price: price ?? this.price,
        location: location ?? this.location,
        description: description ?? this.description,
        condition: condition ?? this.condition,
        imageUrls: imageUrls ?? this.imageUrls,
      );

  factory FurnitureListing.fromJson(String str) =>
      FurnitureListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FurnitureListing.fromMap(Map<String, dynamic> json) =>
      FurnitureListing(
        id: json['id'],
        mainImageUrl: json['main_image_url'],
        title: json['title'],
        price: json['price'],
        location: Location.fromMap(json['location']),
        description: json['description'],
        condition: json['condition'],
        imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'main_image_url': mainImageUrl,
        'title': title,
        'price': price,
        'location': location.toMap(),
        'description': description,
        'condition': condition,
        'image_urls': List<dynamic>.from(imageUrls.map((x) => x)),
      };
}
