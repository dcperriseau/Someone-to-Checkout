import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/models/vehicle_listing.dart';
import 'package:someonetoview/models/furniture_listing.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a post to Firestore
  Future<void> addPost(dynamic listing) async {
    try {
      if (listing is PropertyListing) {
        await _db.collection('property_listings').doc(listing.id).set(listing.toMap());
      } else if (listing is VehicleListing) {
        await _db.collection('vehicle_listings').doc(listing.id).set(listing.toMap());
      } else if (listing is FurnitureListing) {
        await _db.collection('furniture_listings').doc(listing.id).set(listing.toMap());
      } else {
        throw Exception('Unknown listing type');
      }
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  // Get all property posts from Firestore
  Stream<List<PropertyListing>> getPropertyPosts() {
    return _db.collection('property_listings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PropertyListing.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Get all vehicle posts from Firestore
  Stream<List<VehicleListing>> getVehiclePosts() {
    return _db.collection('vehicle_listings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return VehicleListing.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Get all furniture posts from Firestore
  Stream<List<FurnitureListing>> getFurniturePosts() {
    return _db.collection('furniture_listings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FurnitureListing.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Update a post in Firestore
  Future<void> updatePost(dynamic listing) async {
    try {
      if (listing is PropertyListing) {
        await _db.collection('property_listings').doc(listing.id).update(listing.toMap());
      } else if (listing is VehicleListing) {
        await _db.collection('vehicle_listings').doc(listing.id).update(listing.toMap());
      } else if (listing is FurnitureListing) {
        await _db.collection('furniture_listings').doc(listing.id).update(listing.toMap());
      } else {
        throw Exception('Unknown listing type');
      }
    } catch (e) {
      print('Error updating post: $e');
    }
  }
}
