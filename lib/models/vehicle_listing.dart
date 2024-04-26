import 'dart:convert';

class VehicleListing {
  final String mainImageUrl;
  final String title;
  final int price;
  final Location location;
  final String description;
  final int mileage;
  final List<String> imageUrls;

  VehicleListing({
    required this.mainImageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.mileage,
    required this.imageUrls,
  });

  VehicleListing copyWith({
    String? mainImageUrl,
    String? title,
    int? price,
    Location? location,
    String? description,
    int? mileage,
    List<String>? imageUrls,
  }) =>
      VehicleListing(
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
        mainImageUrl: json['main_image_url'],
        title: json['title'],
        price: json['price'],
        location: Location.fromMap(json['location']),
        description: json['description'],
        mileage: json['mileage'],
        imageUrls: List<String>.from(json['image_urls'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'main_image_url': mainImageUrl,
        'title': title,
        'price': price,
        'location': location.toMap(),
        'description': description,
        'mileage': mileage,
        'image_urls': List<dynamic>.from(imageUrls.map((x) => x)),
      };
}

class Location {
  final double longitude;
  final double latitude;
  final String streetAddress;
  final String city;
  final String stateCode;
  final String stateName;
  final int zipCode;

  Location({
    required this.longitude,
    required this.latitude,
    required this.streetAddress,
    required this.city,
    required this.stateCode,
    required this.stateName,
    required this.zipCode,
  });

  Location copyWith({
    double? longitude,
    double? latitude,
    String? streetAddress,
    String? city,
    String? stateCode,
    String? stateName,
    int? zipCode,
  }) =>
      Location(
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        streetAddress: streetAddress ?? this.streetAddress,
        city: city ?? this.city,
        stateCode: stateCode ?? this.stateCode,
        stateName: stateName ?? this.stateName,
        zipCode: zipCode ?? this.zipCode,
      );

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        longitude: json['longitude']?.toDouble(),
        latitude: json['latitude']?.toDouble(),
        streetAddress: json['street_address'],
        city: json['city'],
        stateCode: json['state_code'],
        stateName: json['state_name'],
        zipCode: json['zip_code'],
      );

  Map<String, dynamic> toMap() => {
        'longitude': longitude,
        'latitude': latitude,
        'street_address': streetAddress,
        'city': city,
        'state_code': stateCode,
        'state_name': stateName,
        'zip_code': zipCode,
      };
}
