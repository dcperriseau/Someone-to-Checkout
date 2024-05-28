import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:someonetoview/models/property_listing.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a post to Firestore
  Future<void> addPost(PropertyListing listing) async {
    try {
      await _db.collection('posts').doc(listing.id).set(listing.toMap());
    } catch (e) {
      print('Error adding post: $e');
      
    }
  }

  // Get all posts from Firestore
  Stream<List<PropertyListing>> getPosts() {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PropertyListing.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }


  // Update a post in Firestore
  Future<void> updatePost(PropertyListing listing) async {
    try {
      await _db.collection('posts').doc(listing.id).update(listing.toMap());
    } catch (e) {
      print('Error updating post: $e');
      
    }
  }
}
