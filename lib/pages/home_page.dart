// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/pages/property/property_listing_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PropertyListing>? propertyListings;

  @override
  void initState() {
    super.initState();
    loadPropertyListings();
  }

  Future<void> loadPropertyListings() async {
    final jsonString = await rootBundle.loadString('assets/property_listings.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      propertyListings = jsonData.map((item) => PropertyListing.fromMap(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Listings'),
      ),
      body: propertyListings == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: propertyListings!.length,
              itemBuilder: (context, index) {
                var listing = propertyListings![index];
                return PropertyListingWidget(propertyListing: listing);
              },
            ),
    );
  }
}
