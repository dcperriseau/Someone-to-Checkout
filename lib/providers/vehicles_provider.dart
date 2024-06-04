import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/models/vehicle_listing.dart';

final vehiclesProvider =
    StateNotifierProvider<VehicleProvider, List<VehicleListing>>((ref) {
  return VehicleProvider();
});

// state notifier
class VehicleProvider extends StateNotifier<List<VehicleListing>> {
  VehicleProvider() : super([]);

  void addEntry(VehicleListing listing) {
    state = [listing, ...state];
  }

  void setListing(List<VehicleListing> listings) {
    state = [...listings];
  }

  void removeListing(VehicleListing listing) {
    List<VehicleListing> stateCopy = [...state];

    stateCopy.removeWhere((element) => element.hashCode == listing.hashCode);

    state = [...stateCopy];
  }

  void updateListing(VehicleListing listing) {
    final listingIndex =
        state.indexWhere((element) => element.id == listing.id);

    final stateCopy = state;
    stateCopy[listingIndex] = listing;
    state = [...stateCopy];
  }

  VehicleListing getListing(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  void clearList() {
    state = [];
  }
}
