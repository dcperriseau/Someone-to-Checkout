import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/models/furniture_listing.dart';

final furnitureProvider =
    StateNotifierProvider<FurnitureProvider, List<FurnitureListing>>((ref) {
  return FurnitureProvider();
});

// state notifier
class FurnitureProvider extends StateNotifier<List<FurnitureListing>> {
  FurnitureProvider() : super([]);

  void addEntry(FurnitureListing listing) {
    state = [listing, ...state];
  }

  void setListing(List<FurnitureListing> listings) {
    state = [...listings];
  }

  void removeListing(FurnitureListing listing) {
    List<FurnitureListing> stateCopy = [...state];

    stateCopy.removeWhere((element) => element.hashCode == listing.hashCode);

    state = [...stateCopy];
  }

  void updateListing(FurnitureListing listing) {
    final listingIndex =
        state.indexWhere((element) => element.id == listing.id);

    final stateCopy = state;
    stateCopy[listingIndex] = listing;
    state = [...stateCopy];
  }

  FurnitureListing getListing(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  void clearList() {
    state = [];
  }
}
