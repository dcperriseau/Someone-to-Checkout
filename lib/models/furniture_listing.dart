import 'dart:convert';
import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/location.dart';

class FurnitureListing {
  final String id;
  final String username;
  final String userEmail;
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
    required this.userEmail,
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
    String? userEmail,
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
        userEmail: userEmail ?? this.userEmail,
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

  factory FurnitureListing.fromJson(Map<String, dynamic> json) => FurnitureListing.fromMap(json);

  String toJson() => json.encode(toMap());

  factory FurnitureListing.fromMap(Map<String, dynamic> json) => FurnitureListing(
        id: json['id'],
        username: json['username'],
        userEmail: json['userEmail'],
        dateCreated: DateTime.parse(json['date_created']),
        lastUpdated: DateTime.parse(json['last_updated']),
        mainImageUrl: json['main_image_url'],
        title: json['title'],
        price: json['price'],
        location: Location.fromMap(json['location']),
        description: json['description'],
        condition: json['condition'],
        imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
        availableTimes: json['available_times'] != null ? AvailableTimes.fromJson(json['available_times']) : null,
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
        'image_urls': List<dynamic>.from(imageUrls.map((x) => x)),
        'available_times': availableTimes?.toMap(),
      };
}
