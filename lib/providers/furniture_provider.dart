import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:someonetoview/models/furniture_listing.dart';

final furnitureProvider = StateNotifierProvider<FurnitureNotifier, List<FurnitureListing>>((ref) {
  return FurnitureNotifier();
});

class FurnitureNotifier extends StateNotifier<List<FurnitureListing>> {
  FurnitureNotifier() : super([]) {
    fetchFurnitureListings();
  }

  Future<void> fetchFurnitureListings() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('furniture_listings').get();
      final listings = querySnapshot.docs.map((doc) => FurnitureListing.fromMap(doc.data() as Map<String, dynamic>)).toList();
      state = listings;
    } catch (e) {
      // Handle error accordingly
      print('Error fetching furniture listings: $e');
    }
  }

  void addEntry(FurnitureListing listing) {
    state = [listing, ...state];
  }

  void setListing(List<FurnitureListing> listings) {
    state = [...listings];
  }

  void removeListing(FurnitureListing listing) {
    List<FurnitureListing> stateCopy = [...state];
    stateCopy.removeWhere((element) => element.id == listing.id);
    state = [...stateCopy];
  }

  void updateListing(FurnitureListing listing) {
    final listingIndex = state.indexWhere((element) => element.id == listing.id);
    if (listingIndex != -1) {
      state[listingIndex] = listing;
      state = [...state];
    }
  }

  FurnitureListing getListing(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  void clearList() {
    state = [];
  }
}
