import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/models/property_listing.dart';

final propertyProvider =
    StateNotifierProvider<PropertyProvider, List<PropertyListing>>((ref) {
  return PropertyProvider();
});

// state notifier
class PropertyProvider extends StateNotifier<List<PropertyListing>> {
  PropertyProvider() : super([]);

  void addEntry(PropertyListing listing) {
    state = [listing, ...state];
  }

  void setListing(List<PropertyListing> listings) {
    state = [...listings];
  }

  void removeListing(PropertyListing listing) {
    List<PropertyListing> stateCopy = [...state];

    stateCopy.removeWhere((element) => element.hashCode == listing.hashCode);

    state = [...stateCopy];
  }

  void updateListing(PropertyListing listing) {
    final listingIndex =
        state.indexWhere((element) => element.id == listing.id);

    final stateCopy = state;
    stateCopy[listingIndex] = listing;
    state = [...stateCopy];
  }

  PropertyListing getListing(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  void clearList() {
    state = [];
  }
}
