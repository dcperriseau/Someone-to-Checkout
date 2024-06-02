import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:someonetoview/models/property_listing.dart';

final propertyProvider = StateNotifierProvider<PropertyNotifier, List<PropertyListing>>((ref) {
  return PropertyNotifier();
});

class PropertyNotifier extends StateNotifier<List<PropertyListing>> {
  PropertyNotifier() : super([]) {
    fetchPropertyListings();
  }

  Future<void> fetchPropertyListings() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('property_listings').get();
      final listings = querySnapshot.docs.map((doc) => PropertyListing.fromMap(doc.data() as Map<String, dynamic>)).toList();
      state = listings;
    } catch (e) {
      // Handle error accordingly
    }
  }

  void addEntry(PropertyListing listing) {
    state = [listing, ...state];
  }

  void setListing(List<PropertyListing> listings) {
    state = [...listings];
  }

  void removeListing(PropertyListing listing) {
    List<PropertyListing> stateCopy = [...state];
    stateCopy.removeWhere((element) => element.id == listing.id);
    state = [...stateCopy];
  }

  void updateListing(PropertyListing listing) {
    final listingIndex = state.indexWhere((element) => element.id == listing.id);
    if (listingIndex != -1) {
      state[listingIndex] = listing;
      state = [...state];
    }
  }

  PropertyListing getListing(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  void clearList() {
    state = [];
  }
}
