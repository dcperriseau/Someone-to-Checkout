import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/firestore_service.dart';
import 'package:someonetoview/models/property_listing.dart';

final propertyProvider = StreamProvider<List<PropertyListing>>((ref) {
  final firestoreService = FirestoreService();
  return firestoreService.getPosts();
});

