import 'dart:convert';

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
        longitude: (json['longitude'] as num).toDouble(),
        latitude: (json['latitude'] as num).toDouble(),
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
