import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:someonetoview/models/vehicle_listing.dart';

final vehiclesProvider = StateNotifierProvider<VehicleNotifier, List<VehicleListing>>((ref) {
  return VehicleNotifier();
});

class VehicleNotifier extends StateNotifier<List<VehicleListing>> {
  VehicleNotifier() : super([]) {
    fetchVehicleListings();
  }

  Future<void> fetchVehicleListings() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('vehicle_listings').get();
      final listings = querySnapshot.docs.map((doc) => VehicleListing.fromMap(doc.data() as Map<String, dynamic>)).toList();
      state = listings;
    } catch (e) {
      // Handle error accordingly
    }
  }

  void addEntry(VehicleListing listing) {
    state = [listing, ...state];
  }

  void setListing(List<VehicleListing> listings) {
    state = [...listings];
  }

  void removeListing(VehicleListing listing) {
    List<VehicleListing> stateCopy = [...state];
    stateCopy.removeWhere((element) => element.id == listing.id);
    state = [...stateCopy];
  }

  void updateListing(VehicleListing listing) {
    final listingIndex = state.indexWhere((element) => element.id == listing.id);
    if (listingIndex != -1) {
      state[listingIndex] = listing;
      state = [...state];
    }
  }

  VehicleListing getListing(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  void clearList() {
    state = [];
  }
}
