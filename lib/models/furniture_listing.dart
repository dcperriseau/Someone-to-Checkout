import 'dart:convert';

import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/location.dart';

class FurnitureListing {
  final String id;
  final String username;
  final DateTime dateCreated;
  final DateTime lastUpdated;
  final String mainImageUrl;
  final String title;
  final int price;
  final Location location;
  final String description;
  final String condition;
  final List<String> imageUrls;
  final AvailableTimes? availableTimes;

  FurnitureListing({
    required this.id,
    required this.username,
    required this.dateCreated,
    required this.lastUpdated,
    required this.mainImageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.condition,
    required this.imageUrls,
    this.availableTimes,
  });

  FurnitureListing copyWith({
    String? id,
    String? username,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    String? mainImageUrl,
    String? title,
    int? price,
    Location? location,
    String? description,
    String? condition,
    List<String>? imageUrls,
    AvailableTimes? availableTimes,
  }) =>
      FurnitureListing(
        id: id ?? this.id,
        username: username ?? this.username,
        dateCreated: dateCreated ?? this.dateCreated,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        mainImageUrl: mainImageUrl ?? this.mainImageUrl,
        title: title ?? this.title,
        price: price ?? this.price,
        location: location ?? this.location,
        description: description ?? this.description,
        condition: condition ?? this.condition,
        imageUrls: imageUrls ?? this.imageUrls,
        availableTimes: availableTimes ?? this.availableTimes,
      );

  factory FurnitureListing.fromJson(String str) =>
      FurnitureListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FurnitureListing.fromMap(Map<String, dynamic> json) =>
      FurnitureListing(
        id: json['id'],
        username: json['username'],
        dateCreated: DateTime.parse(json['date_created']),
        lastUpdated: DateTime.parse(json['date_created']),
        mainImageUrl: json['main_image_url'],
        title: json['title'],
        price: json['price'],
        location: Location.fromMap(json['location']),
        description: json['description'],
        condition: json['condition'],
        imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
        availableTimes: AvailableTimes.fromJson(json['available_times']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'date_created': dateCreated.toIso8601String(),
        'last_updated': lastUpdated.toIso8601String(),
        'main_image_url': mainImageUrl,
        'title': title,
        'price': price,
        'location': location.toMap(),
        'description': description,
        'condition': condition,
        'image_urls': List<String>.from(imageUrls.map((x) => x)),
        'available_times': availableTimes?.toMap(),
      };
}
