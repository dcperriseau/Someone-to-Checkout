import 'dart:convert';

import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/location.dart';

class VehicleListing {
  final String id;
  final String username;
  final DateTime dateCreated;
  final DateTime lastUpdated;
  final String mainImageUrl;
  final String title;
  final int price;
  final Location location;
  final String description;
  final int mileage;
  final List<String> imageUrls;
  final AvailableTimes? availableTimes;

  VehicleListing({
    required this.id,
    required this.username,
    required this.dateCreated,
    required this.lastUpdated,
    required this.mainImageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.mileage,
    required this.imageUrls,
    this.availableTimes,
  });

  VehicleListing copyWith({
    String? id,
    String? username,
    DateTime? dateCreated,
    DateTime? lastUpdated,
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
        username: username ?? this.username,
        dateCreated: dateCreated ?? this.dateCreated,
        lastUpdated: lastUpdated ?? this.lastUpdated,
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
        username: json['username'],
        dateCreated: DateTime.parse(json['date_created']),
        lastUpdated: DateTime.parse(json['date_created']),
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
        'available_times': availableTimes?.toMap(),
      };
}
