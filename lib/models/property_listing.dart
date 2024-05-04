import 'dart:convert';

import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/location.dart';

class PropertyListing {
  final String id;
  final String mainImageUrl;
  final String title;
  final int price;
  final Location location;
  final String description;
  final int bedroomCount;
  final int bathroomCount;
  final List<String> imageUrls;
  final AvailableTimes? availableTimes;

  PropertyListing({
    required this.id,
    required this.mainImageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.bedroomCount,
    required this.bathroomCount,
    required this.imageUrls,
    this.availableTimes,
  });

  PropertyListing copyWith({
    String? id,
    String? mainImageUrl,
    String? title,
    int? price,
    Location? location,
    String? description,
    int? bedroomCount,
    int? bathroomCount,
    List<String>? imageUrls,
    AvailableTimes? availableTimes,
  }) =>
      PropertyListing(
        id: id ?? this.id,
        mainImageUrl: mainImageUrl ?? this.mainImageUrl,
        title: title ?? this.title,
        price: price ?? this.price,
        location: location ?? this.location,
        description: description ?? this.description,
        bedroomCount: bedroomCount ?? this.bedroomCount,
        bathroomCount: bathroomCount ?? this.bathroomCount,
        imageUrls: imageUrls ?? this.imageUrls,
        availableTimes: availableTimes ?? this.availableTimes,
      );

  factory PropertyListing.fromJson(String str) =>
      PropertyListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PropertyListing.fromMap(Map<String, dynamic> json) => PropertyListing(
        id: json['id'],
        mainImageUrl: json['main_image_url'],
        title: json['title'],
        price: json['price'],
        location: Location.fromMap(json['location']),
        description: json['description'],
        bedroomCount: json['bedroom_count'],
        bathroomCount: json['bathroom_count'],
        imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'main_image_url': mainImageUrl,
        'title': title,
        'price': price,
        'location': location.toMap(),
        'description': description,
        'bedroom_count': bedroomCount,
        'bathroom_count': bathroomCount,
        'image_urls': List<dynamic>.from(imageUrls.map((x) => x)),
        'available_times': availableTimes?.toMap(),
      };
}
