import 'dart:convert';
import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/location.dart';

class PropertyListing {
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
  final int bedroomCount;
  final int bathroomCount;
  final List<String> imageUrls;
  final AvailableTimes? availableTimes;

  PropertyListing({
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
    required this.bedroomCount,
    required this.bathroomCount,
    required this.imageUrls,
    this.availableTimes,
  });

  PropertyListing copyWith({
    String? id,
    String? username,
    DateTime? dateCreated,
    String? userEmail,
    DateTime? lastUpdated,
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
        username: username ?? this.username,
        userEmail: userEmail ?? this.userEmail,
        dateCreated: dateCreated ?? this.dateCreated,
        lastUpdated: lastUpdated ?? this.lastUpdated,
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

  factory PropertyListing.fromJson(String str) => PropertyListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PropertyListing.fromMap(Map<String, dynamic> json) => PropertyListing(
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
    bedroomCount: json['bedroom_count'],
    bathroomCount: json['bathroom_count'],
    imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
    availableTimes: json['available_times'] != null
        ? AvailableTimes.fromJson(json['available_times'])
        : null,
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
    'bedroom_count': bedroomCount,
    'bathroom_count': bathroomCount,
    'image_urls': List<dynamic>.from(imageUrls.map((x) => x)),
    'available_times': availableTimes?.toMap(),
  };
}
