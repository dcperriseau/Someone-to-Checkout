import 'dart:math';

import 'package:someonetoview/models/available_times.dart';
import 'package:someonetoview/models/furniture_listing.dart';
import 'package:someonetoview/models/location.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/models/vehicle_listing.dart';
import 'package:uuid/uuid.dart';

class Generator {
  static List<PropertyListing> generatePropertyListings() {
    // Sample data for location
    Location location = Location(
      longitude: -118.264854,
      latitude: 34.077164,
      streetAddress: '123 Main St',
      city: 'Los Angeles',
      stateCode: 'CA',
      stateName: 'California',
      zipCode: 90057,
    );

    // Sample data for image URLs
    List<String> imageUrls = [
      'https://picsum.photos/id/10/300/300',
      'https://picsum.photos/id/11/300/300',
      'https://picsum.photos/id/12/300/300',
      'https://picsum.photos/id/13/300/300',
      'https://picsum.photos/id/14/300/300',
    ];

    // Generate random sample data for VehicleListing
    List<PropertyListing> listings = [];

    String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    String finalDesc = '';

    TimeSlot timeSlot1 = TimeSlot(start: '8:00 AM', end: '12:00 PM');
    TimeSlot timeSlot2 = TimeSlot(start: '3:00 PM', end: '5:00 PM');

    for (int i = 0; i < 4; i++) {
      finalDesc += ' $description';
    }

    for (int i = 0; i < 12; i++) {
      int imageIndex = Random().nextInt(15);
      PropertyListing listing = PropertyListing(
        id: const Uuid().v4(),
        username: 'Fake User',
        userEmail: 'fakeUser@gmail.com',
        dateCreated: DateTime.now().subtract(const Duration(days: 4)),
        lastUpdated: DateTime.now().subtract(const Duration(hours: 36)),
        mainImageUrl: 'https://picsum.photos/id/$imageIndex/300',
        title: 'Property Listing Here ${i + 1}',
        price: Random().nextInt(4000) + 500,
        location: location,
        description: finalDesc,
        bedroomCount: Random().nextInt(2) + 1,
        bathroomCount: Random().nextInt(1) + 1,
        imageUrls: ['https://picsum.photos/id/$imageIndex/300', ...imageUrls],
        availableTimes: AvailableTimes(
          sunday: [timeSlot1, timeSlot2],
          monday: 'none',
          tuesday: [timeSlot1],
          wednesday: [timeSlot2],
          thursday: 'none',
          friday: [timeSlot1, timeSlot2],
          saturday: 'none',
        ),
      );

      listings.add(listing);
    }

    return listings;
  }

  static List<FurnitureListing> generateFurnitureListings() {
    // Sample data for location
    Location location = Location(
      longitude: -118.264854,
      latitude: 34.077164,
      streetAddress: '123 Main St',
      city: 'Los Angeles',
      stateCode: 'CA',
      stateName: 'California',
      zipCode: 90057,
    );

    // Sample data for image URLs
    List<String> imageUrls = [
      'https://picsum.photos/id/10/300/300',
      'https://picsum.photos/id/11/300/300',
      'https://picsum.photos/id/12/300/300',
      'https://picsum.photos/id/13/300/300',
      'https://picsum.photos/id/14/300/300',
    ];

    // Generate random sample data for VehicleListing
    List<FurnitureListing> listings = [];

    String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    String finalDesc =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

    for (int i = 0; i < 3; i++) {
      finalDesc += ' $description';
    }

    // Sample data for TimeSlots
    TimeSlot timeSlot1 = TimeSlot(start: '9:00 AM', end: '12:00 PM');
    TimeSlot timeSlot2 = TimeSlot(start: '1:00 PM', end: '5:00 PM');

    for (int i = 0; i < 12; i++) {
      int imageIndex = Random().nextInt(15);
      FurnitureListing listing = FurnitureListing(
        id: const Uuid().v4(),
        username: 'Fake User',
        userEmail: 'fakeUser@gamil.com',
        dateCreated: DateTime.now().subtract(const Duration(days: 4)),
        lastUpdated: DateTime.now().subtract(const Duration(hours: 36)),
        mainImageUrl: 'https://picsum.photos/id/$imageIndex/300',
        title: 'Furniture Listing ${i + 1}',
        price: Random().nextInt(500) + 10,
        location: location,
        description: finalDesc,
        condition: 'Used',
        imageUrls: ['https://picsum.photos/id/$imageIndex/300', ...imageUrls],
        availableTimes: AvailableTimes(
          sunday: [timeSlot1, timeSlot2],
          monday: 'none',
          tuesday: [timeSlot1],
          wednesday: [timeSlot2],
          thursday: 'none',
          friday: [timeSlot1, timeSlot2],
          saturday: 'none',
        ),
      );

      listings.add(listing);
    }

    return listings;
  }

  static List<VehicleListing> generateVehicleListings() {
    // Sample data for location
    Location location = Location(
      longitude: -118.264854,
      latitude: 34.077164,
      streetAddress: '123 Main St',
      city: 'Los Angeles',
      stateCode: 'CA',
      stateName: 'California',
      zipCode: 90057,
    );

    // Sample data for image URLs
    List<String> imageUrls = [
      'https://picsum.photos/id/10/300/300',
      'https://picsum.photos/id/11/300/300',
      'https://picsum.photos/id/12/300/300',
      'https://picsum.photos/id/13/300/300',
      'https://picsum.photos/id/14/300/300',
    ];

    // Generate random sample data for VehicleListing
    List<VehicleListing> listings = [];

    String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    String finalDesc = '';

    for (int i = 0; i < 4; i++) {
      finalDesc += ' $description';
    }

    TimeSlot timeSlot1 = TimeSlot(start: '6:00 AM', end: '11:00 AM');
    TimeSlot timeSlot2 = TimeSlot(start: '1:00 PM', end: '5:30 PM');

    for (int i = 0; i < 12; i++) {
      int imageIndex = Random().nextInt(15);
      VehicleListing listing = VehicleListing(
        id: const Uuid().v4(),
        username: 'Fake User',
        userEmail: 'fakeUser@gamil.com',
        dateCreated: DateTime.now().subtract(const Duration(days: 4)),
        lastUpdated: DateTime.now().subtract(const Duration(hours: 36)),
        mainImageUrl: 'https://picsum.photos/id/$imageIndex/300',
        title: 'Vehicle Listing ${i + 1}',
        price: Random().nextInt(30000) + 1000,
        location: location,
        description: finalDesc,
        mileage: Random().nextInt(200000) + 100000,
        imageUrls: ['https://picsum.photos/id/$imageIndex/300', ...imageUrls],
        availableTimes: AvailableTimes(
          sunday: [timeSlot1, timeSlot2],
          monday: 'none',
          tuesday: [timeSlot1],
          wednesday: [timeSlot2],
          thursday: 'none',
          friday: [timeSlot1, timeSlot2],
          saturday: 'none',
        ),
      );

      listings.add(listing);
    }

    return listings;
  }
}
